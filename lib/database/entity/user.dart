import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String username;
  final String password;
  final String email;
  final bool isBiometric;

  User(this.username, this.password, this.email, this.isBiometric);
}