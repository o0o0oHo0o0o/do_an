import 'package:flutter/material.dart';
import 'package:weather/models/mess.dart';

class MessTile extends StatelessWidget {

  final Mess mess;
  const MessTile({required this.mess});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.deepOrange[100],
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.deepOrange[200],
                child: Icon(Icons.person_2_outlined, color: Colors.white),
              ),
              title: Text(
                mess.content,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Health: ${mess.health} + Outlay: ${mess.outlay} \$',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            if (mess.imageUrl != null && mess.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(mess.imageUrl!),
              ),
          ],
        ),
      ),
    );
  }
}
