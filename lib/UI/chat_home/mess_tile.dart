import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/models/mess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MessTile extends StatelessWidget {

  final Mess mess;
  const MessTile({required this.mess});

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        color: myConstants.contentColor,
        shape: RoundedRectangleBorder(
          // side: BorderSide(color: Colors.grey, width: 1), // Thêm viền
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ListTile(
              tileColor: myConstants.messColor,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.deepOrange[200],
                child: const Icon(Icons.person_2_outlined, color: Colors.white),
              ),
              title: const Text(
                'Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                _formatDate(mess.timestamp),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
            Text(
              '${mess.content}',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            if (mess.imageUrl != null && mess.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(mess.imageUrl!)
                ),
              ),
          ],
        ),
      ),
    );
  }
  String _formatDate(Timestamp timestamp) {
    DateTime time = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(time);
    print('Timestamp: $time');
    print('Now: $now');
    if (difference.inSeconds < 60) {
      return 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      int minutes = difference.inMinutes;
      return '$minutes phút trước';
    } else if (difference.inHours < 24) {
      int hours = difference.inHours;
      return '$hours giờ trước';
    } else if (difference.inDays < 7) {
      int days = difference.inDays;
      return '$days ngày trước';
    } else {
      return DateFormat('dd/MM/yyyy').format(time);
    }// Định dạng ngày/tháng/năm
  }
}
