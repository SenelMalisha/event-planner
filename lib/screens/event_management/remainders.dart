import 'package:event_planner/database/entity/reminder.dart';
import 'package:event_planner/utils/constants.dart';
import 'package:event_planner/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../database/repository/app_repository.dart';
import '../../widgets/custom_shape_clipper.dart';
import 'add_reminder.dart';

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  String searchText = "";
  bool isPersonal = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[ReminderScreenTop(onCountChanged: (String search, bool toggle){
            setState(() {
              searchText = search;
              isPersonal = toggle;
            });
          },), ReminderScreenBottom(searchText: searchText, isPersonal: isPersonal,)],
        ),
      ),
    );
  }
}

class ReminderScreenTop extends StatefulWidget {
  final Function(String, bool) onCountChanged;
  const ReminderScreenTop({Key? key, required this.onCountChanged}) : super(key: key);

  @override
  State<ReminderScreenTop> createState() => _ReminderScreenTopState();
}

class _ReminderScreenTopState extends State<ReminderScreenTop> {
  var selectedDropdown = 0;
  bool isSelectedPersonal = true;
  String searchText = "";
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> reminderList = [
      'Recurring Reminder',
      'Tomorrow Reminders',
      'Today Reminders',
      'All Reminders'
    ];
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 400.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bgDark, bgBlackLight],
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.alarm_on,
                          color: kBackgroundColor,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        PopupMenuButton(
                          onSelected: (index) {
                            setState(() {
                              selectedDropdown = index;
                              debugPrint(selectedDropdown.toString());
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                reminderList[selectedDropdown],
                                style: const TextStyle(
                                  color: kBackgroundColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: kBackgroundColor,
                              )
                            ],
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuItem<int>>[
                            PopupMenuItem(
                              child: Text(
                                reminderList[0],
                                style: const TextStyle(
                                  color: bgDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              value: 0,
                            ),
                            PopupMenuItem(
                              child: Text(
                                reminderList[1],
                                style: const TextStyle(
                                  color: bgDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              value: 1,
                            )
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,MaterialPageRoute(builder: (context) => AddReminder()),);
                          },
                          child: Icon(
                            Icons.add,
                            color: kBackgroundColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Text(
                    StringValues.lblSearchReminder,
                    style: TextStyle(fontSize: 24, color: kBackgroundColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: TextField(

                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          this.setState(() {
                            searchText = value;
                          });
                          widget.onCountChanged(searchText, isSelectedPersonal);
                        },
                        controller: searchController,
                        style: const TextStyle(
                          color: bgTextColorBlack,
                        ),
                        decoration: InputDecoration(
                          hintText: StringValues.lblSearchReminder,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 10),
                          suffix: Material(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Icon(
                              Icons.search_rounded,
                              color: bgDark,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: ReminderOptions(
                            icon: Icons.broadcast_on_personal_outlined,
                            text: StringValues.lblPersonal,
                            isSelected: isSelectedPersonal),
                        onTap: () {
                          setState(() {
                            isSelectedPersonal = true;
                          });
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: ReminderOptions(
                            icon: Icons.work,
                            text: StringValues.lblWork,
                            isSelected: !isSelectedPersonal),
                        onTap: () {
                          setState(() {
                            isSelectedPersonal = false;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class ReminderOptions extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  ReminderOptions(
      {required this.icon, required this.text, required this.isSelected});

  @override
  State<ReminderOptions> createState() => _ReminderOptionsState();
}

class _ReminderOptionsState extends State<ReminderOptions> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: widget.isSelected
          ? BoxDecoration(
              color: kBackgroundColor.withOpacity(0.15),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            widget.icon,
            size: 20.0,
            color: kBackgroundColor,
          ),
          SizedBox(width: 8),
          Text(widget.text,
              style: const TextStyle(
                color: kBackgroundColor,
                fontSize: 16,
                fontWeight: FontWeight.w100,
              ))
        ],
      ),
    );
  }
}

class ReminderScreenBottom extends StatefulWidget {
  final String searchText;
  final bool isPersonal;
  const ReminderScreenBottom({Key? key, required this.searchText, required this.isPersonal}) : super(key: key);

  @override
  State<ReminderScreenBottom> createState() => _ReminderScreenBottomState();
}

class _ReminderScreenBottomState extends State<ReminderScreenBottom> {
  static AppRepository _appRepository = GetIt.instance.get<AppRepository>();
  List<Reminder> reminders = [];

  @override
  void initState() {
    print("initstate");
    _getRemindersFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _getRemindersFromDb();
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                StringValues.lblResults,
                style: const TextStyle(
                  color: bgDark,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              itemCount: reminders.length,
              itemBuilder: (BuildContext context, int index) {
                return ReminderCard(reminder: reminders[index]);
              },
            )
          ],
        ),
      ),
    );
  }

  void _getRemindersFromDb() async{
    if(widget.searchText.isEmpty) {
      print("EMPTY SEARCH");
      _appRepository.getReminder().then((value) {
        this.setState(() {
          reminders = value.reversed.toList();
        });
      });
    } else {
      print("FILTER SEARCH");
      _appRepository.getReminderBySearchText("%"+widget.searchText+"%", widget.isPersonal?"Personal":"Work").then((value) {
        this.setState(() {
          reminders = value.reversed.toList();
        });
      });
    }

  }
}

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  const ReminderCard({Key? key, required this.reminder }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Card(
              elevation: 20,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminder.title,
                        style: const TextStyle(
                            color: bgDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none),
                      ),
                      Wrap(spacing: 8, runSpacing: -8, children: [
                        ReminderChip(Icons.timer, reminder.time),
                        ReminderChip(Icons.calendar_month, reminder.date),
                        ReminderChip(Icons.loop, reminder.isRepeat),
                      ])
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 8,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                //set border radius more than 50% of height and width to make circle
              ),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  getRemainingDays(reminder.date),
                  style: TextStyle(color: kBackgroundColor, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(0))),
              ),
            ),
          )
        ],
      ),
    );
  }

  int daysBetween(DateTime from, DateTime now) {
    from = DateTime(from.year, from.month, from.day);
    now = DateTime(now.year, now.month, now.day);
    return (now.difference(from).inHours/24).round();
  }

  String getRemainingDays(String date) {
    DateTime currentDate = DateTime.now();
    DateTime toDate = DateTime.parse(date);
    debugPrint("getRemainingHours " + daysBetween(currentDate, toDate).toString());
    return daysBetween(currentDate, toDate).toString() + " Days";
  }

}

class ReminderChip extends StatelessWidget {
  final IconData iconData;
  final String label;

  ReminderChip(this.iconData, this.label);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(color: bgDark, fontSize: 12),
      backgroundColor: tagColor,
      avatar: Icon(
        iconData,
        size: 15,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
