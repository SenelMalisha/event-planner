import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../api/speech_api.dart';
import '../../models/voice_commands.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SpeechToTextHome extends StatefulWidget {
  const SpeechToTextHome({Key? key}) : super(key: key);

  @override
  State<SpeechToTextHome> createState() => _SpeechToTextHomeState();
}

class _SpeechToTextHomeState extends State<SpeechToTextHome> {

  String text = "Press the button and start speaking";
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
              builder: (context) {
                return IconButton(onPressed: () async{
                  FlutterClipboard.copy(text);
                  //Scaffold.of(context).showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
                },
                    icon: const Icon(Icons.content_copy_rounded));
              }
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: const Text("Voice Navigation"),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.h,right: 2.h,top: 5.h,bottom: 150),
                child: SubstringHighlight(text:text,
                  textAlign: TextAlign.center,
                  textStyle: Styles.normalTextStyle(20.sp, primaryColor),
                  term: getTerm(text),
                  textStyleHighlight: const TextStyle(fontSize: 32, color: Colors.red,fontWeight: FontWeight.w600),
                ),
              ),
              Image.asset("assets/lottie/voice.gif", width: 50.w,)
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75,
        child: FloatingActionButton(
          onPressed: () {
            toggleRecording(context);
          },
          child: Icon(isListening?Icons.mic :Icons.mic_none_rounded, size: 35,),),
      ),
    );
  }
  Future toggleRecording(BuildContext context) => SpeechApi.toggleRecording(
      onResult: (text) => setState(()=>this.text = text),
      onListening: (bool isListening) {
        setState(() {
          this.isListening = isListening;
        });
        if(!isListening){
          Future.delayed(const Duration(milliseconds: 1000), () {
            Utils.scanText(text, context);
          });

        }
      });

  String? getTerm (String text){
    if(text.contains(Commands.email)){
      return Commands.email;
    } else if (text.contains(Commands.browser1)){
      return Commands.browser1;
    } else if (text.contains(Commands.browser2)){
      return Commands.browser2;
    } else if (text.contains(Commands.logout)){
      return Commands.logout;
    } else {
      return "";
    }
  }
}
