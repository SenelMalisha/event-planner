import 'package:event_planner/database/entity/reminder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../database/repository/app_repository.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_shape_clipper.dart';
import '../google_map/google_map.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgDark,
        centerTitle: true,
        title: const Text(StringValues.lblAddEvent),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [AddEventTop(), AddEventScreenBottom()],
        ),
      ),
    );
  }
}

class AddEventTop extends StatefulWidget {
  const AddEventTop({Key? key}) : super(key: key);

  @override
  State<AddEventTop> createState() => _AddEventTopState();
}

class _AddEventTopState extends State<AddEventTop> {
  @override
  Widget build(BuildContext context) {
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
                          "Add Your Event",
                          style: const TextStyle(
                            color: kBackgroundColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class AddEventScreenBottom extends StatefulWidget {
  const AddEventScreenBottom({Key? key}) : super(key: key);

  @override
  State<AddEventScreenBottom> createState() =>
      _AddEventScreenBottomState();
}

class _AddEventScreenBottomState extends State<AddEventScreenBottom> {
  static AppRepository _appRepository = GetIt.instance.get<AppRepository>();
  final List<bool> _selectedOption = <bool>[true, false];
  int repeatIndex = 0;
  DateTime selectedDate = DateTime.now();
  String selectedTime = "Select time";
  String pickedDate = "Select Date";
  final titleController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        pickedDate = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> displayTimeDialog(BuildContext context) async {
    final TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
      });
    }
  }

  Widget buildEventLocation() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/images/map.jpg',
        height: MediaQuery.of(context).size.height / 3,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringValues.lblReminderTitle,
              style: const TextStyle(
                  color: bgDark, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: titleController,
              style: TextStyle(color: bgTextColorBlack),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: bgDark), //<--<-- SEE HERE
                ),
                hintText: 'Enter Event Title',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              StringValues.lblDate,
              style: const TextStyle(
                  color: bgDark, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              readOnly: true,
              onTap: (){_selectDate(context);},
              style: TextStyle(color: bgTextColorBlack),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: bgDark), //<-- SEE HERE
                ),
                hintText: pickedDate,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              StringValues.lblTime,
              style: const TextStyle(
                  color: bgDark, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              readOnly: true,
              onTap: () {
                displayTimeDialog(context);
              },
              style: TextStyle(color: bgTextColorBlack),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: bgDark), //<-- //<-- SEE HERE
                ),
                hintText: selectedTime,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              StringValues.lblLocationEvent,
              style: const TextStyle(
                  color: bgDark, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
              child: Center(child: buildEventLocation())
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {

                      if(titleController.text.isNotEmpty && selectedTime != "Select time" && pickedDate != "Select Date"){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Event added successfully"),
                        ));
                        Navigator.pop(context);
                      }

                      //_appRepository.addReminder(Reminder(selectedType, titleController.text, selectedTime, pickedDate,"false", _selectedOption[repeatIndex].toString()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: bgDark)
                      ),
                      primary: bgDark,
                      elevation: 8,
                      shadowColor: Colors.black87,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        StringValues.lblAddEvent,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
