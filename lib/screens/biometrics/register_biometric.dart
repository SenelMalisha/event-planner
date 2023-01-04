
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../enum/biometric_type.dart';
import '../../services/local_auth_service.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';
import '../on_boarding/on_boarding_home.dart';

class BiometricRegister extends StatefulWidget {

  BiometricRegister({Key? key})
      : super(key: key);

  @override
  _BiometricRegisterState createState() => _BiometricRegisterState();
}

class _BiometricRegisterState extends State<BiometricRegister> with WidgetsBindingObserver {
  bool isFaceIdAvailable = false;
  bool isTouchIdAvailable = false;
  bool isBiometricAvailable = false;
  bool isGoToSettings = false;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    checkBiometricAvailable();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed)
      checkBiometricAvailable();
  }

  void checkBiometricAvailable() async {
    await LocalAuthService.getBiometrics().then((biometrics) {
      biometrics.forEach((biometric) {
        isGoToSettings = false;
        if (biometric == BiometricType.face) {
          isFaceIdAvailable = true;
        } else if (biometric == BiometricType.fingerprint) {
          isTouchIdAvailable = true;
        } else if (biometric == BiometricType.weak ||
            biometric == BiometricType.strong || biometric == BiometricType.iris) {
          isBiometricAvailable = true;
        }
      });
      if (!isFaceIdAvailable && !isTouchIdAvailable && !isBiometricAvailable) {
        isGoToSettings = true;
        setupBiometric();
      }
      setState(() {});
    });
  }

  setupBiometric() async {
    await LocalAuthService.authenticate().then((isAuthenticated) {
      if (isAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingHome()),
        );
      }
    });
  }

  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000),
              Color(0xFF000000),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -30,
            child: topWidget(screenSize.width),
          ),
          Positioned(
            bottom: -180,
            left: -40,
            child: bottomWidget(screenSize.width),
          ),
          Container(
            width: width,
            height: height,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3.h, bottom: 4.h),
                  child: Lottie.asset(
                    'assets/lottie/security.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                  child: const Text(
                    "Register biometric login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: bgTextColorBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildCustomButton(
                    width / 1.5,
                    StringValues.btn_setup_touch_id,
                    BiometricAuthType.TouchId,
                    isTouchIdAvailable),
                _buildCustomButton(
                    width / 1.5,
                    StringValues.btn_setup_face_id,
                    BiometricAuthType.FaceId,
                    isFaceIdAvailable),
                _buildCustomButton(
                    width / 1.5,
                    StringValues.btn_setup_biometrics,
                    BiometricAuthType.Biometric,
                    isBiometricAvailable),
                _buildCustomButton(
                    width / 1.5,
                    StringValues.btn_go_to_settings,
                    BiometricAuthType.Biometric,
                    isGoToSettings),
                _buildSkipButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCustomButton(double width, String buttonName,
      BiometricAuthType biometricType, bool isVisible) {
    return Visibility(
      visible: isVisible,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: width,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: bgDark,
                onPrimary: kBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.h)),
              ),
              onPressed: () {
                setupBiometric();
              },
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                child: Text(
                  buttonName,
                    style: const TextStyle(
                      color: bgTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              )),
        ),
      ),
    );
  }

  _buildSkipButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(top: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextButton(
                  autofocus: false,
                  onPressed: () {

                  },
                  child: const Text(
                    StringValues.btn_cancel,
                    style: TextStyle(
                      color: bgTextColorBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                  )),
            ),
          ],
        ),
      ),
    );
  }

}
