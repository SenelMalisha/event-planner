import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell/widget.dart';

import '../../database/entity/event.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_shape_clipper.dart';

class Schedules extends StatefulWidget {
  const Schedules({Key? key}) : super(key: key);

  @override
  State<Schedules> createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  @override
  Widget build(BuildContext context) {
    return ScheduleBottom();
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     scrollDirection: Axis.vertical,
    //     child: Column(
    //       children: [ScheduleBottom()],
    //     ),
    //   ),
    // );
    // return Column(
    //   children: [ScheduleBottom()],
    // );
  }

}

class ScheduleBottom extends StatefulWidget {
  const ScheduleBottom({Key? key}) : super(key: key);

  @override
  State<ScheduleBottom> createState() => _ScheduleBottomState();
}

class _ScheduleBottomState extends State<ScheduleBottom> {
  late List<Event> _eventList;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
        _eventList = [
      Event(
          "Leo's Birthday",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          "birthday event",
          "Colombo bavarian pub",
          "12:00 AM",
          "11 Jan 2023",
          "assets/images/bg_birthday.jpg"),
      Event(
          "Trip to Maldives",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          "birthday event",
          "Katunayake Airport",
          "12:00 AM",
          "12 Feb 2023",
          "assets/images/bg_travel.jpg"),
      Event(
          "Jack and Jill's Wedding",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          "birthday event",
          "Taj Samudra",
          "12:00 AM",
          "11 Jan 2023",
          "assets/images/bg_wedding.jpg"),
      Event(
          "Marco's Birthday",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          "birthday event",
          "Movenpick rooftop",
          "11 Dec 2023",
          "12:00 AM",
          "assets/images/bg_birthday.jpg"),
      Event(
          "Kim and Jon's Wedding",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          "birthday event",
          "Jetwing Galle",
          "11 Feb 2023",
          "12:00 AM",
          "assets/images/bg_wedding.jpg"),
      Event(
          "Trip to Ella",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          "birthday event",
          "Kaduwela Highway Entrance",
          "11 Mar 2023",
          "12:00 AM",
          "assets/images/bg_travel.jpg"),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: _eventList.length,
        itemBuilder: (context, index) {
          return SimpleFoldingCell.create(
            frontWidget: _buildFrontWidget(index),
            // innerTopWidget: _buildInnerWidget(index),
            innerWidget: _buildInnerBottomWidget(index),
            cellSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 4),
            padding: EdgeInsets.all(10),
            animationDuration: Duration(milliseconds: 200),
            onOpen: () => this.setState(() {
              _isExpanded = true;
            }),
            onClose: () => this.setState(() {
              _isExpanded = false;
            }),
          );
        },
      ),
    );
  }


  Widget _buildFrontWidget(int index) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            final foldingCellState =
            context.findAncestorStateOfType<SimpleFoldingCellState>();
            foldingCellState?.toggleFold();
          },
          child: Card(
            elevation: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(_eventList[index].background),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.srcOver))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(_eventList[index].title,
                          style: const TextStyle(
                            color: kBackgroundColor,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(_eventList[index].date,
                                  style: const TextStyle(
                                    color: kBackgroundColor,
                                    fontWeight: FontWeight.w600,
                                  ))),
                        )),
                  ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInnerBottomWidget(index) {
    return Visibility(
      visible: true,
      child: Builder(builder: (context) {
        return Stack(children: [
          Card(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: kFaded, borderRadius: BorderRadius.circular(5.0)),
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 16),
                  child: Column(
                    children: [
                      Text(_eventList[index].title,
                          style: const TextStyle(
                            color: bgTextColorBlack,
                            fontWeight: FontWeight.w600,
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: new Divider(
                          color: bgDark,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                        child: Text(_eventList[index].description,
                            style: const TextStyle(
                              color: bgTextColorBlack,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Text(StringValues.lblTime,
                                style: const TextStyle(
                                  color: bgTextColorBlack,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(_eventList[index].time,
                                style: const TextStyle(
                                  color: bgTextColorBlack,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Text(StringValues.lblDate,
                                style: const TextStyle(
                                  color: bgTextColorBlack,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(_eventList[index].time,
                                style: const TextStyle(
                                  color: bgTextColorBlack,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Text(StringValues.lblLocation,
                                style: const TextStyle(
                                  color: bgTextColorBlack,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Text(_eventList[index].location,
                                style: const TextStyle(
                                  color: bgTextColorBlack,
                                )),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipOval(
                                child: Material(
                                  color: bgDark, // Button color
                                  child: InkWell(
                                    splashColor: bgLight, // Splash color
                                    onTap: () {
                                      final foldingCellState =
                                      context.findAncestorStateOfType<
                                          SimpleFoldingCellState>();
                                      foldingCellState?.toggleFold();
                                    },
                                    child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.close,
                                          color: kBackgroundColor,
                                        )),
                                  ),
                                ),
                              )))
                    ],
                  )),
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: ConfettiWidget(
          //     confettiController: _controllerTopCenter,
          //     blastDirection: pi / 2,
          //     maxBlastForce: 2, // set a lower max blast force
          //     minBlastForce: 1, // set a lower min blast force
          //     emissionFrequency: 0.05,
          //     numberOfParticles: 30, // a lot of particles at once
          //     gravity: 1,
          //   ),
          // ),
        ]);
      }),
    );
  }
}

class ScheduleTop extends StatefulWidget {
  const ScheduleTop({Key? key}) : super(key: key);

  @override
  State<ScheduleTop> createState() => _ScheduleTopState();
}

class _ScheduleTopState extends State<ScheduleTop> {
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
              height: 200.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bgDark, bgBlackLight],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your Schedules",
                          style: const TextStyle(
                            color: kBackgroundColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
