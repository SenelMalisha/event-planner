import 'package:event_planner/database/entity/reminder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../database/repository/app_repository.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_shape_clipper.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({Key? key}) : super(key: key);

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgDark,
        centerTitle: true,
        title: const Text(StringValues.lblAddReminder),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [AddReminderTop(), AddReminderScreenBottom()],
        ),
      ),
    );
  }
}

class AddReminderTop extends StatefulWidget {
  const AddReminderTop({Key? key}) : super(key: key);

  @override
  State<AddReminderTop> createState() => _AddReminderTopState();
}

class _AddReminderTopState extends State<AddReminderTop> {
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
                          "Add your reminder",
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

class AddReminderScreenBottom extends StatefulWidget {
  const AddReminderScreenBottom({Key? key}) : super(key: key);

  @override
  State<AddReminderScreenBottom> createState() =>
      _AddReminderScreenBottomState();
}

class _AddReminderScreenBottomState extends State<AddReminderScreenBottom> {
  static AppRepository _appRepository = GetIt.instance.get<AppRepository>();
  final List<bool> _selectedOption = <bool>[true, false];
  final List<bool> _selectedType = <bool>[true, false];
  int repeatIndex = 0;
  String selectedType = "Personal";
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

  //display time
  Future<void> displayTimeDialog(BuildContext context) async {
    final TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
      });
    }
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
                hintText: 'Enter reminder title',
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
              StringValues.lblRepeatReminder,
              style: const TextStyle(
                  color: bgDark, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedOption.length; i++) {
                    _selectedOption[i] = i == index;
                    repeatIndex = index;
                  }
                });
              },
              borderWidth: 2,
              borderColor: bgDark,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: bgDark,
              selectedColor: kBackgroundColor,
              fillColor: bgDark,
              color: bgDark,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedOption,
              children: [Text("YES"), Text("NO")],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              StringValues.lblReminderType,
              style: const TextStyle(
                  color: bgDark, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedType.length; i++) {
                    _selectedType[i] = i == index;
                    index == 0 ? selectedType = "Personal" : selectedType = "Work";
                  }
                });
              },
              borderWidth: 2,
              borderColor: bgDark,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: bgDark,
              selectedColor: kBackgroundColor,
              fillColor: bgDark,
              color: bgDark,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedType,
              children: [Text("Personal"), Text("Work")],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Reminder added successfully"),
                  ));
                  _appRepository.addReminder(Reminder(selectedType, titleController.text, selectedTime, pickedDate,"false", _selectedOption[repeatIndex].toString()));
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
                    StringValues.lblAddReminder,
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
