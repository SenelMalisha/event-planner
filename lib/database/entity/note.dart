
import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String title;
  final String description;

  Note(this.title, this.description);
}