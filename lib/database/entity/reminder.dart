import 'package:floor/floor.dart';

@entity
class Reminder {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String type;
  final String title;
  final String time;
  final String date;
  final String isCompleted;
  final String isRepeat;


  Reminder(this.type, this.title, this.time, this.date, this.isCompleted, this.isRepeat);
}