import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class CustomToast extends StatelessWidget {
final String message;
CustomToast(this.message);
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow()],
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: blue3,),
          SizedBox(
            width: 12.w,
          ),
      Text(message ??
              message,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
        ],
      ),
    );
  }
}

void customToast(BuildContext context, String message){
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: CustomToast(message),
    gravity: ToastGravity.TOP,
    toastDuration: Duration(seconds: 2),
  );
}
