import 'package:event_planner/database/entity/event.dart';
import 'package:event_planner/database/entity/note.dart';
import 'package:event_planner/database/entity/reminder.dart';
import 'package:event_planner/database/entity/schedule.dart';
import 'package:event_planner/database/entity/user.dart';
import 'package:floor/floor.dart';

@dao
abstract class AppDao {
  @insert
  Future<void> insertUser(User user);

  @Query('SELECT * FROM Note')
  Future<List<Note>> getAllNotes();

  @Query('SELECT * FROM Note WHERE id = :id')
  Stream<Note?> findNoteById(int id);

  @insert
  Future<void> insertNote(Note note);

  @Query('SELECT * FROM Event')
  Future<List<Event>> getAllEvents();

  @Query('SELECT * FROM Event WHERE id = :id')
  Stream<Note?> findEventById(int id);

  @insert
  Future<void> insertEvent(Event event);

  @Query('SELECT * FROM Reminder')
  Future<List<Reminder>> getAllReminders();

  @Query('SELECT * FROM Reminder WHERE id = :id')
  Stream<Reminder?> findReminderById(int id);

  @insert
  Future<void> insertReminder(Reminder reminder);

  @Query('SELECT * FROM Schedule')
  Future<List<Schedule>> getAllSchedule();

  @Query('SELECT * FROM Schedule WHERE id = :id')
  Stream<Note?> findScheduleById(int id);

  @insert
  Future<void> insertSchedule(Schedule event);
}