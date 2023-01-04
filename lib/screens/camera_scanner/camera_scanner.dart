import 'package:event_planner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../utils/strings.dart';


class CameraScanner extends StatefulWidget {
  const CameraScanner({Key? key}) : super(key: key);

  @override
  State<CameraScanner> createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  String _imagePath = "";
  final ImagePicker _picker = ImagePicker();
  late final TextDetector _textDetector;
  String printText = "";
  bool isScanned = false;

  @override
  void initState() {
    // Initializing the text detector
    _textDetector = GoogleMlKit.vision.textDetector();
    _recognizeTexts();
    super.initState();
  }

  void _recognizeTexts() async {

    setState(() {
      isScanned = false;
    });
    printText = "";
    String tempPrintText = "";
    // Creating an InputImage object using the image path
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _imagePath = image!.path;
    InputImage inputImage = InputImage.fromFilePath(_imagePath);
    // Retrieving the RecognisedText from the InputImage
    RecognisedText text = await _textDetector.processImage(inputImage);
    // Finding text String(s)
    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        tempPrintText = tempPrintText + "\n" +line.text;
      }
    }
    setState(() {
      printText = tempPrintText;
      if(printText.isNotEmpty){
        isScanned = true;
      }
    });
  }

  /// Display photo album for picking.
  Future<void> _onAlbumLabelTap(BuildContext c) async {
    // _pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgDark,
        centerTitle: true,
        title: const Text(StringValues.lblCameraScanner),
      ),
      body: Column(
        children: [
          Visibility(
            visible: isScanned,
            child: Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Lottie.asset(
                  'assets/lottie/scanlogo.json',
                  height: 15.h,
                  fit: BoxFit.fill,
                  repeat: false,
                animate: isScanned
              ),
            ),
          ),
          Visibility(
            visible: isScanned,
            child: Center(
                    child: Container(
                      height: height/2.5,
                      decoration: myBoxDecoration(),
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                      child: Text(
                        printText,
                        textAlign: TextAlign.start,
                        style:  const TextStyle(
                          color: bgTextColorBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),))),
          ),
          Visibility(
            visible: !isScanned,
            child: Container(
              height: height/1.5,
              child: Lottie.asset(
                  'assets/lottie/scan.json',
                  width: width/2,
                  repeat: true
              ),
            ),
          ),
          Center(
              child: Visibility(
                visible: isScanned,
                child: Container(
                  width: width/2,
             child: ElevatedButton(
                    onPressed: () {
                      _recognizeTexts();
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const StadiumBorder(),
                  primary: bgDark,
                  elevation: 8,
                  shadowColor: Colors.black87,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    StringValues.lblPickNewImage,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ),
              )),
          Padding(padding: const EdgeInsets.all(10.0)),
          Center(
              child: Visibility(
                visible: isScanned,
                child: Container(
                  width: width/2,
                  child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: const StadiumBorder(),
                        primary: bgDark,
                        elevation: 8,
                        shadowColor: Colors.black87,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          StringValues.lblCopyTextToNote,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                ),
              )))
        ],
      ),
    );
  }
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }
}
