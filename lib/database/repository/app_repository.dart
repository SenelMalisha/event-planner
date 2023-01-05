
import 'package:event_planner/database/dao/app_dao.dart';
import 'package:get_it/get_it.dart';

import '../entity/note.dart';

class AppRepository {
  late AppDao _appDao;

  AppRepository() {
    _appDao = GetIt.instance.get<AppDao>();
  }

  Future<List<Note>> getAllNotes(){
    return _appDao.getAllNotes();
  }

  void addNote(Note note) {
    _appDao.insertNote(note);
  }

}