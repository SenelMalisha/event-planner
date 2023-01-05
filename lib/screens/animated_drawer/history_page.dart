import 'package:flutter/material.dart';
import '../../utils/strings.dart';
import '../../widgets/menu_widget.dart';
import '../../widgets/voice_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(StringValues.titleHistoryPage),
        leading: const MenuWidget(),
        actions: [VoiceWidget()],
      ),
    );
  }
}
