import 'package:event_planner/database/dao/app_dao.dart';
import 'package:event_planner/database/repository/app_repository.dart';
import 'package:event_planner/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import 'database/database.dart';
import 'screens/login_screen/login_screen.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDatabase();
  runApp(const MyApp());
}

void initializeDatabase() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingletonAsync<AppDatabase>(() async =>
      $FloorAppDatabase.databaseBuilder(StringValues.database_name).build());
  getIt.registerSingletonWithDependencies<AppDao>(() {
    return GetIt.instance.get<AppDatabase>().appDao;
  }, dependsOn: [AppDatabase]);
  getIt.registerSingletonWithDependencies<AppRepository>(
          () => AppRepository(),
      dependsOn: [AppDatabase, AppDao]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Event Planner',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: kPrimaryColor,
                  fontFamily: 'Montserrat',
                ),
          ),
          home: const LoginScreen(),
        );
      }),
    );
  }
}
