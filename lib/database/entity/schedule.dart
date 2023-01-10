import 'package:floor/floor.dart';

@entity
class Schedule {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String title;
  final String description;
  final String scheduleType;
  final String time;
  final bool isRepeat;


  Schedule(this.title, this.description, this.scheduleType, this.time, this.isRepeat);
}