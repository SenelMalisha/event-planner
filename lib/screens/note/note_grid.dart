import 'package:event_planner/screens/camera_scanner/camera_scanner.dart';
import 'package:event_planner/screens/note/note_item.dart';
import 'package:event_planner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';

import '../../database/entity/note.dart';
import '../../database/repository/app_repository.dart';
import '../../utils/strings.dart';

class NotesGridView extends StatefulWidget {
  const NotesGridView({Key? key}) : super(key: key);

  @override
  State<NotesGridView> createState() => _NotesGridViewState();
}

class _NotesGridViewState extends State<NotesGridView> {
  static AppRepository _appRepository = GetIt.instance.get<AppRepository>();
  List<Note> notes = [];

  @override
  void initState() {
    _getNotesFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int columnCount = 2;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: bgDark,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraScanner()),
            );
          },
          child: Icon(Icons.add_a_photo),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        backgroundColor: LinearColor4,
        appBar: AppBar(
          backgroundColor: bgDark,
          centerTitle: true,
          title: const Text(StringValues.lblNotes),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _getNotesFromDb();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              crossAxisCount: columnCount,
              children: List.generate(
                notes.length,
                    (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: columnCount,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: NoteCard(note: notes[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }

  void _getNotesFromDb() async {
    _appRepository.getAllNotes().then((value) {
      this.setState(() {
        notes = value;
      });
    });
  }
}
// GridView.count(
// padding: const EdgeInsets.all(10.0),
// crossAxisCount: 2,
// crossAxisSpacing: 4.0,
// mainAxisSpacing: 8.0,
// children: List.generate(
// notes.length,
// (index) => Center(
// child: NoteCard(note: notes[index]),
// )),
// )