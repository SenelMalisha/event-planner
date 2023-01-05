import 'package:flutter/material.dart';

import '../screens/voice_integration/voice_support_home.dart';

class VoiceWidget extends StatelessWidget {
  const VoiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SpeechToTextHome()),
          );
        },
        icon: const Icon(Icons.keyboard_voice_sharp));
  }
}
