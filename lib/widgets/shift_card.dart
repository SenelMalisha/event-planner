import 'package:event_planner/widgets/shrimer_wrapper.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class NextShiftCard extends StatelessWidget {
  final bool _isLoading;
  final DateTime? _shiftDate;
  final TimeOfDay? _shiftStart;
  final TimeOfDay? _shiftEnd;

  NextShiftCard(this._isLoading, this._shiftDate, this._shiftStart, this._shiftEnd);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: BoarderColor, width: 2)),
        height: MediaQuery.of(context).size.height * 0.1588,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.height * 0.0466,
              child: ClipOval(
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.063,
                  height: MediaQuery.of(context).size.height * 0.063,
                  color: BgColor5,
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/images/ph5.png"),
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.0368,
              left: MediaQuery.of(context).size.width * 0.232,
              child: Row(
                children: [
                  Text("Your Next Shift - ",
                      style: TextStyle(
                        color: NoteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                  _isLoading
                      ? SizedBox(
                    height: 24,
                    child: ShimmerWrapper(
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 3,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  )
                      : Text(_shiftDate != null ? _shiftDate.toString() : '-',
                      style: TextStyle(
                        color: NoteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      )),
                ],
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.232,
              top: MediaQuery.of(context).size.height * 0.0737,
              child: Text("Starts On",
                  style: TextStyle(
                    color: Ocean4,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  )),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.232,
              top: MediaQuery.of(context).size.height * 0.0909,
              child: _isLoading
                  ? SizedBox(
                height: 24,
                child: ShimmerWrapper(
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 3,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              )
                  : Text(_shiftStart != null ? _shiftStart.toString() : '-',
                  style: TextStyle(
                    color: Ocean4,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.078,
              left: MediaQuery.of(context).size.width * 0.5346,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.0368,
                width: 1,
                color: ContainerColor,
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.613,
              top: MediaQuery.of(context).size.height * 0.0737,
              child: Text("Ends On",
                  style: TextStyle(
                    color: Ocean4,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  )),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.613,
              top: MediaQuery.of(context).size.height * 0.0909,
              child: _isLoading
                  ? SizedBox(
                height: 24,
                child: ShimmerWrapper(
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 3,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              )
                  : Text(_shiftEnd != null ? _shiftEnd.toString() : '-',
                  style: TextStyle(
                    color: Ocean4,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
