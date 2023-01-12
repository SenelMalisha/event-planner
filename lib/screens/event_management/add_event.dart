import 'package:date_time_picker/date_time_picker.dart';
import 'package:event_planner/screens/google_map/google_map.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/voice_widget.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late TextEditingController _controller1;
  String _valueChanged1 = 'rr';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'pt_BR';
    //_initialValue = DateTime.now().toString();
    _controller1 = TextEditingController(text: DateTime.now().toString());

    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');

    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        _controller1.text = '2000-09-20 14:30';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black.withOpacity(0.9),
      appBar: AppBar(
          actions: [VoiceWidget()],
          backgroundColor: Colors.black,
          title: Text("Add Your Event")),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text('Hey, John!',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                            // style: Theme.of(context).textTheme.title,
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(height: 12.0,),
                      Text("01. Your Event Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        //style: Theme.of(context).textTheme.subtitle,
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          isDense: true
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("02. Your Event Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        //style: Theme.of(context).textTheme.subtitle,
                      ),
                      //SizedBox(height: 10,),
                      DateTimePicker(
                        style: TextStyle(color: Colors.black),
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        controller: _controller1,
                        //initialValue: _initialValue,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        //use24HourFormat: false,
                        //locale: Locale('pt', 'BR'),
                        selectableDayPredicate: (date) {
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }
                          return true;
                        },
                        onChanged: (val) => setState(() => _valueChanged1 = val),
                        validator: (val) {
                          setState(() => _valueToValidate1 = val ?? '');
                          return null;
                        },
                        onSaved: (val) => setState(() => _valueSaved1 = val ?? ''),
                      ),
                      SizedBox(height: 20,),
                      Text("03. Your Event Type",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                        //style: Theme.of(context).textTheme.subtitle,
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 18.0,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.black,
                            border: Border.all(
                                color: Colors.black, // Set border color
                                width: 1.0),
                           // boxShadow: [BoxShadow(blurRadius: 20,color: Colors.black,offset: Offset(3,3,))]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Image.asset(
                                'assets/img/party-popper.png',
                                width: 30.0,
                                fit: BoxFit.fill,
                              ),
                              //SizedBox(height: 12.0,),
                              Text('All Events',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                                //style: Theme.of(context).textTheme.body1,
                                textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24.0,),
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.black,
                          border: Border.all(
                              color: Colors.black, // Set border color
                              width: 1.0),
                          // boxShadow: [BoxShadow(blurRadius: 20,color: Colors.black,offset: Offset(3,3,))]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                'assets/img/face-with-party-horn-and-party-hat.png',
                                width: 30.0,
                                fit: BoxFit.fill,
                              ),
                              //SizedBox(height: 12.0,),
                              Text('Birthday',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                                //style: Theme.of(context).textTheme.body1,
                                textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24.0,),
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.black,
                          border: Border.all(
                              color: Colors.black, // Set border color
                              width: 1.0),
                          // boxShadow: [BoxShadow(blurRadius: 20,color: Colors.black,offset: Offset(3,3,))]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                'assets/img/man-and-woman-holding-hands.png',
                                width: 30.0,
                                fit: BoxFit.fill,
                              ),
                              //SizedBox(height: 12.0,),
                              Text('Anniversary',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                                //style: Theme.of(context).textTheme.body1,
                                textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 24.0,),
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.black,
                          border: Border.all(
                              color: Colors.black, // Set border color
                              width: 1.0),
                          // boxShadow: [BoxShadow(blurRadius: 20,color: Colors.black,offset: Offset(3,3,))]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                'assets/img/person-raising-both-hands-in-celebration.png',
                                width: 30.0,
                                fit: BoxFit.fill,
                              ),
                              //SizedBox(height: 12.0,),
                              Text('More Events',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                                //style: Theme.of(context).textTheme.body1,
                                textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0,),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 0.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Text('Upcoming events',
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontWeight: FontWeight.w700,
                //             fontSize: 15),
                //         //style: Theme.of(context).textTheme.display1,
                //       ),
                //       Text('01/10',
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontWeight: FontWeight.w600,
                //             fontSize: 13),
                //         // style: Theme.of(context).textTheme.display2,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 18.0,),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         height: 140.0,
                //         width: 260.0,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(24.0),
                //             image: DecorationImage(
                //                 image: AssetImage('assets/img/facetime.png'),
                //                 fit: BoxFit.cover,
                //                 colorFilter: ColorFilter.mode(pureBlack.withOpacity(0.4), BlendMode.darken)
                //             )
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 10.0),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: <Widget>[
                //               Row(
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: <Widget>[
                //                   Icon(
                //                     Icons.calendar_today,
                //                     color: pureWhite,
                //                     size: 10.0,
                //                   ),
                //                   SizedBox(width: 4.0,),
                //                   Text('October 14, 2019',
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.w600,
                //                         fontSize: 14),
                //                     //style: Theme.of(context).textTheme.body2,
                //                   )
                //                 ],
                //               ),
                //               SizedBox(height: 8.0,),
                //               Text('Dribbble meatup Denmark',
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w600,
                //                     fontSize: 14),
                //                 //style: Theme.of(context).textTheme.subhead,
                //               ),
                //               SizedBox(height: 4.0,),
                //             ],
                //           ),
                //         ),
                //       ),
                //       SizedBox(width: 18.0,),
                //       Container(
                //         height: 140.0,
                //         width: 250.0,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(24.0),
                //             image: DecorationImage(
                //                 image: AssetImage('assets/img/bandmembers.png'),
                //                 fit: BoxFit.cover,
                //                 colorFilter: ColorFilter.mode(pureBlack.withOpacity(0.4), BlendMode.darken)
                //             )
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 10.0),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: <Widget>[
                //               Row(
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: <Widget>[
                //                   Icon(
                //                     Icons.calendar_today,
                //                     color: pureWhite,
                //                     size: 10.0,
                //                   ),
                //                   SizedBox(width: 4.0,),
                //                   Text('October 14, 2019',
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.w600,
                //                         fontSize: 14),
                //                     //style: Theme.of(context).textTheme.body2,
                //                   )
                //                 ],
                //               ),
                //               SizedBox(height: 8.0,),
                //               Text('Dribbble meatup Denmark',
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w600,
                //                     fontSize: 14),
                //                 //style: Theme.of(context).textTheme.subhead,
                //               ),
                //               SizedBox(height: 4.0,),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('04. Your location',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                      //style: Theme.of(context).textTheme.display1,
                    ),
                    SizedBox(height: 18.0,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MapScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 110.0,
                              // width: 170.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/img/map2.png'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(pureBlack.withOpacity(0.75), BlendMode.darken),
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('\u00b0',
                                    //style: Theme.of(context).textTheme.display3,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 18.0,),
                          Expanded(
                            child: Container(
                                 height: 110.0,
                                // width: 170.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        stops: [
                                          0.0,
                                          0.2,
                                          0.8,
                                        ],
                                        colors: [pureBlack.withOpacity(0.7), pureBlack.withOpacity(0.86), pureBlack.withOpacity(0.9)]
                                    )
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: <Widget>[
                                    Positioned(
                                      top: -6.0,
                                      right: -6.0,
                                      child: Container(
                                        width: 55.0,
                                        height: 55.0,
                                        decoration: BoxDecoration(
                                          color: lightGrey.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -15.0,
                                      right: -15.0,
                                      child: Container(
                                        width: 75.0,
                                        height: 75.0,
                                        decoration: BoxDecoration(
                                          color: lightGrey.withOpacity(0.06),
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Image.asset(
                                        'assets/icons/moon-white4.png',
                                        width: 16.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(14.0, 0.0, 0.0, 20.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text('14',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15),
                                                  //style: Theme.of(context).textTheme.display4,
                                                ),
                                                Text('\u00b0',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 15),
                                                  // style: Theme.of(context).textTheme.display4,
                                                ),
                                              ],
                                            ),
                                            Text("Copenhagen, Denmark", style: Theme.of(context).textTheme.overline,),
                                          ],
                                        )
                                    )
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
