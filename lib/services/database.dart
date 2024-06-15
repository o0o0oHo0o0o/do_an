import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/models/mess.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference messCollection = FirebaseFirestore.instance.collection('mess');

  Future<String> uploadImage(File image) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null ) {
      throw Exception('Only Firebase authenticated users can upload images');
    }

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${user.uid}/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(image);

      await uploadTask.whenComplete(() => null);

      return await storageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      print('FirebaseException: ${e.code} - ${e.message}');
      throw Exception('Upload failed: ${e.code} - ${e.message}');
    } catch (e) {
      // Handle any other errors
      print('Exception: ${e.toString()}');
      throw Exception('Upload failed: ${e.toString()}');
    }
  }

  Future updateUserData(String content, int health, String outlay, [String? imageUrl]) async {
    return await messCollection.doc(uid).set({
      'content': content,
      'health': health,
      'outlay': outlay,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  Future addUserData(String content, int health, String outlay, [String? imageUrl]) async {
    return await messCollection.add({
      'content': content,
      'health': health,
      'outlay': outlay,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'uid': uid, // Lưu trữ uid của người dùng để dễ dàng truy vấn
    });
  }
  // Crypto list from snapshot
  List<Mess> _messListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      return Mess(
        content: data?['content'] ?? '',
        health: data?['health'] ?? 0,
        outlay: data?['outlay'] ?? '',
        imageUrl: data?['imageUrl'] ?? '',
        timestamp: data?['createdAt'] ?? Timestamp.now(),
      );
    }).toList();
  }
  //userData from snapshot
  MessData _messDataFromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      return MessData(uid: uid, content: '', health: 0, outlay: '', imageUrl: '',timestamp: Timestamp.now());
    }
    return MessData(
      uid: uid,
      content: data['content'] ?? '',
      health: data['health'] ?? 0,
      outlay: data['outlay'] ?? '',
      imageUrl: data['imageUrl'],
      timestamp: data['createAt'] as Timestamp,
    );
  }

  // Mess stream
  Stream<List<Mess>> get mess {
    return messCollection.snapshots().map(_messListFromSnapshot);
  }
  Stream<MessData> get messData{
    return messCollection.doc(uid).snapshots().map(_messDataFromSnapshot);
  }
}
