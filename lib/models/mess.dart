import 'package:cloud_firestore/cloud_firestore.dart';
class Mess{
  final String content;
  final int health;
  final String outlay;
  final String? imageUrl;
  final Timestamp timestamp;

  Mess({
    required this.content,
    required this.health,
    required this.outlay,
    this.imageUrl,
    required this.timestamp
  });
}

class MessData{
  final String content;
  final int health;
  final String outlay;
  final String uid;
  final String? imageUrl;
  final Timestamp timestamp;
  MessData({
    required this.uid,
    required this.content,
    required this.health,
    required this.outlay,
    this.imageUrl,
    required this.timestamp,
  });
}