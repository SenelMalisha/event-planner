import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:money_assistant_2608/project/database_management/sqflite_services.dart';
import 'dart:io' show Platform;
import '../../services/sqflite_services.dart';
import '../../utils/constants.dart';
import 'expenses/analysis.dart';
import 'expenses/calendar.dart';
import 'expenses/input.dart';
import 'expenses/others.dart';


class Expenses extends StatefulWidget {
  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    builder: (ctx, child) {
      ScreenUtil.init(ctx);
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.blue,
          //textTheme: TextTheme(bodyText2: TextStyle(fontSize: 30.sp)),
        ),
        child: ExpensesHome(),
      );
    },
    );
  }
}

class ExpensesHome extends StatefulWidget {
  @override
  _ExpensesHomeState createState() => _ExpensesHomeState();
}

class _ExpensesHomeState extends State<ExpensesHome> {
  int _selectedIndex = 0;
  List<Widget> myBody = [
    AddInput(),
    Analysis(),
    Calendar(),
    //Other(),
  ];
  BottomNavigationBarItem bottomNavigationBarItem(
      IconData iconData, String label) =>
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(bottom: 0.h),
          child: Icon(
            iconData,
          ),
        ),
        label: label,
      );

  @override
  void initState() {
    super.initState();
    DB.init();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {

    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(428.0, 926.0));
    List<BottomNavigationBarItem> bottomItems = <BottomNavigationBarItem>[
      bottomNavigationBarItem(Icons.add, 'Input'),
      bottomNavigationBarItem(Icons.analytics_outlined, 'Analysis'),
      bottomNavigationBarItem(Icons.calendar_today, 'Calendar'),
     // bottomNavigationBarItem(Icons.account_circle, 'Other'),
    ];

    return Scaffold(
        // appBar: AppBar(
        //     backgroundColor: Colors.black,
        //     title:
        //     //Text("Events")
        //     _selectedIndex == 0
        //         ? Text("Add Expense")
        //         :
        //     _selectedIndex == 1
        //         ? Text("Analysis")
        //         :
        //     _selectedIndex == 2
        //         ? Text("Calendar")
        //         :
        //     Text("Other")),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: grey,
              ),
            ],
          ),
          child: BottomNavigationBar(
            iconSize: 27.sp,
            selectedFontSize: 16.sp,
            unselectedFontSize: 14.sp,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: bottomItems,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: myBody[_selectedIndex]);
  }
}
