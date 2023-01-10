import 'package:floor/floor.dart';

@entity
class Reminder {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String title;
  final String description;
  final String time;
  final bool isRepeat;


  Reminder(this.title, this.description, this.time, this.isRepeat);
}