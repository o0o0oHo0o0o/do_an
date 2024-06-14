import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/mess.dart';

import 'mess_tile.dart';
class messList extends StatefulWidget {
  const messList({super.key});

  @override
  State<messList> createState() => _cryptoListState();
}

class _cryptoListState extends State<messList> {
  @override
  Widget build(BuildContext context) {
    final messes = Provider.of<List<Mess>>(context);

    return ListView.builder(
      itemCount: messes.length,
      itemBuilder: (context, index){
        return MessTile(mess: messes[index]);
      },
    );
  }
}


