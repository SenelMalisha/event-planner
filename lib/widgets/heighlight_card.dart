import 'package:event_planner/widgets/shrimer_wrapper.dart';
import 'package:flutter/material.dart';

import '../models/personal_heighlight.dart';
import '../utils/constants.dart';

class PersonalHighlightCard extends StatelessWidget {
  final PersonalHighlight _highlight;
  final bool _isLoading;

  PersonalHighlightCard(this._highlight, this._isLoading);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: BoxShadow1, offset: Offset(3, 3), blurRadius: 30),
      ], color: _highlight.color1, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(right: 11, top: 20, bottom: 25),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: ClipOval(
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.058,
                  height: MediaQuery.of(context).size.height * 0.058,
                  color: _highlight.color2,
                  child: Center(
                    child: Image(
                      image: AssetImage(_highlight.imagePath),
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                _highlight.title,
                style: TextStyle(color: TitleColor1, fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            _isLoading
                ? SizedBox(
              height: 29,
              child: Row(
                children: [
                  ShimmerWrapper(
                    child: Container(
                      width: 70,
                      height: 3,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
                : Text(
              _highlight.detail1,
              style: TextStyle(color: blackColor1, fontWeight: FontWeight.w700, fontSize: 24),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.0294,
              ),
              child: Text(
                _highlight.detail2,
                style: TextStyle(color: rateColor, fontWeight: FontWeight.w600, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
