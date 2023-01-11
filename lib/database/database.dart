import 'dart:async';
import 'package:event_planner/database/dao/app_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entity/event.dart';
import 'entity/note.dart';
import 'entity/schedule.dart';
import 'entity/reminder.dart';
import 'entity/user.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Note, Event, Reminder, Schedule, User])
abstract class AppDatabase extends FloorDatabase {
  AppDao get appDao;
}