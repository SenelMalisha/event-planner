import 'package:event_planner/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/entity/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 10,
        color: kBackgroundColor,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: height/6,
                    child: Container(
                      child: Expanded(
                        child: Text(
                          note.description,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(color: bgTextColorBlack, fontWeight: FontWeight.bold, fontSize: 10.0),
                        ),
                      ),
                    ))
              )]
        ),
        )
    );
  }
}