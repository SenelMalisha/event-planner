import 'package:flutter/material.dart';

/** created by Himashi Bogahawaththa **/
/** Eyepax IT Consulting (Pvt) Ltd **/
/** created on 1/17/2023 at 3:25 PM **/

class SeekBarData{
  final Duration position;
  final Duration duration;

  SeekBarData(
      this.position,
      this.duration
  );
}

class SeekBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangedEnd;

  const SeekBar({Key? key,
    required this.position,
    required this.duration,
    this.onChanged,
    this.onChangedEnd
  }) : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: RoundSliderThumbShape(
                  disabledThumbRadius: 4,
                  enabledThumbRadius: 4,
                ) ,
                overlayShape: RoundSliderOverlayShape(
                  overlayRadius: 10
                ),
                activeTrackColor: Colors.white.withOpacity(0.2),
                inactiveTrackColor: Colors.white,
                thumbColor: Colors.white,
                overlayColor: Colors.white
              ),
              child: Slider(
                value: 0,
                onChanged: (value) {},
              )
          ),
        )
      ],
    );
  }
}
