import 'package:event_planner/database/entity/note.dart';
import 'package:floor/floor.dart';

@dao
abstract class AppDao {
  @Query('SELECT * FROM Note')
  Future<List<Note>> getAllNotes();

  @Query('SELECT * FROM Note WHERE id = :id')
  Stream<Note?> findNoteById(int id);

  @insert
  Future<void> insertNote(Note note);
}