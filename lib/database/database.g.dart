// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AppDao? _appDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Event` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `eventType` TEXT NOT NULL, `location` TEXT NOT NULL, `time` TEXT NOT NULL, `date` TEXT NOT NULL, `background` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Reminder` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `time` TEXT NOT NULL, `isRepeat` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Schedule` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `scheduleType` TEXT NOT NULL, `time` TEXT NOT NULL, `isRepeat` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT NOT NULL, `password` TEXT NOT NULL, `email` TEXT NOT NULL, `isBiometric` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AppDao get appDao {
    return _appDaoInstance ??= _$AppDao(database, changeListener);
  }
}

class _$AppDao extends AppDao {
  _$AppDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password,
                  'email': item.email,
                  'isBiometric': item.isBiometric ? 1 : 0
                }),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                },
            changeListener),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'Event',
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'eventType': item.eventType,
                  'location': item.location,
                  'time': item.time,
                  'date': item.date,
                  'background': item.background
                }),
        _reminderInsertionAdapter = InsertionAdapter(
            database,
            'Reminder',
            (Reminder item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'time': item.time,
                  'isRepeat': item.isRepeat ? 1 : 0
                },
            changeListener),
        _scheduleInsertionAdapter = InsertionAdapter(
            database,
            'Schedule',
            (Schedule item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'scheduleType': item.scheduleType,
                  'time': item.time,
                  'isRepeat': item.isRepeat ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final InsertionAdapter<Reminder> _reminderInsertionAdapter;

  final InsertionAdapter<Schedule> _scheduleInsertionAdapter;

  @override
  Future<List<Note>> getAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM Note',
        mapper: (Map<String, Object?> row) =>
            Note(row['title'] as String, row['description'] as String));
  }

  @override
  Stream<Note?> findNoteById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Note WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Note(row['title'] as String, row['description'] as String),
        arguments: [id],
        queryableName: 'Note',
        isView: false);
  }

  @override
  Future<List<Event>> getAllEvents() async {
    return _queryAdapter.queryList('SELECT * FROM Event',
        mapper: (Map<String, Object?> row) => Event(
            row['title'] as String,
            row['description'] as String,
            row['eventType'] as String,
            row['location'] as String,
            row['time'] as String,
            row['date'] as String,
            row['background'] as String));
  }

  @override
  Stream<Note?> findEventById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Event WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Note(row['title'] as String, row['description'] as String),
        arguments: [id],
        queryableName: 'Event',
        isView: false);
  }

  @override
  Future<List<Reminder>> getAllReminders() async {
    return _queryAdapter.queryList('SELECT * FROM Reminder',
        mapper: (Map<String, Object?> row) => Reminder(
            row['title'] as String,
            row['description'] as String,
            row['time'] as String,
            (row['isRepeat'] as int) != 0));
  }

  @override
  Stream<Reminder?> findReminderById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Reminder WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Reminder(
            row['title'] as String,
            row['description'] as String,
            row['time'] as String,
            (row['isRepeat'] as int) != 0),
        arguments: [id],
        queryableName: 'Reminder',
        isView: false);
  }

  @override
  Future<List<Schedule>> getAllSchedule() async {
    return _queryAdapter.queryList('SELECT * FROM Schedule',
        mapper: (Map<String, Object?> row) => Schedule(
            row['title'] as String,
            row['description'] as String,
            row['scheduleType'] as String,
            row['time'] as String,
            (row['isRepeat'] as int) != 0));
  }

  @override
  Stream<Note?> findScheduleById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Schedule WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Note(row['title'] as String, row['description'] as String),
        arguments: [id],
        queryableName: 'Schedule',
        isView: false);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertEvent(Event event) async {
    await _eventInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertReminder(Reminder reminder) async {
    await _reminderInsertionAdapter.insert(reminder, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertSchedule(Schedule event) async {
    await _scheduleInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }
}
