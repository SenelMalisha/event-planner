import 'package:event_planner/database/dao/app_dao.dart';
import 'package:event_planner/database/entity/reminder.dart';
import 'package:event_planner/database/entity/schedule.dart';
import 'package:get_it/get_it.dart';

import '../entity/event.dart';
import '../entity/note.dart';
import '../entity/user.dart';

class AppRepository {
  late AppDao _appDao;

  AppRepository() {
    _appDao = GetIt.instance.get<AppDao>();
  }

  void addUser(User user) {
    _appDao.insertUser(user);
  }

  Future<List<User>> getUser(String username, String password){
    return _appDao.getUser(username, password);
  }

  Future<List<Note>> getAllNotes(){
    return _appDao.getAllNotes();
  }

  void addNote(Note note) {
    _appDao.insertNote(note);
  }

  Future<List<Event>> getAllEvents(){
    return _appDao.getAllEvents();
  }

  void addEvent(Event event) {
    _appDao.insertEvent(event);
  }

  Future<List<Reminder>> getReminder(){
    return _appDao.getAllReminders();
  }

  void deleteReminder(int id) {
    _appDao.deleteReminder(id);
  }

  Future<List<Reminder>> getReminderBySearchText(String searchText, String type){
    return _appDao.searchReminder(searchText, type);
  }

  void addReminder(Reminder reminder) {
    _appDao.insertReminder(reminder);
  }

  Future<List<Schedule>> getSchedule(){
    return _appDao.getAllSchedule();
  }

  void addSchedule(Schedule schedule) {
    _appDao.insertSchedule(schedule);
  }

}