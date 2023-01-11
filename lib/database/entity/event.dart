import 'package:floor/floor.dart';

@entity
class Event {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String title;
  final String description;
  final String eventType;
  final String location;
  final String time;
  final String date;
  final String background;


  Event(this.title, this.description, this.eventType, this.location, this.time, this.date, this.background);
}