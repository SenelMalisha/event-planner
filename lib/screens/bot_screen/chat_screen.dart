import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:event_planner/screens/bot_screen/bot.dart';
import 'package:flutter/material.dart';

/** created by Himashi Bogahawaththa **/
/** Eyepax IT Consulting (Pvt) Ltd **/
/** created on 1/5/2023 at 12:57 PM **/

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My bot"),
          backgroundColor: Colors.black,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white70
          ),
          child: Column(
            children: [
              Expanded(child: MyBot(
                messages: messages, scrollController: scrollController,)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a message'
                          ),
                        )
                    ),
                    IconButton(
                        onPressed: () {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                          sendMessage(_controller.text);
                          _controller.clear();
                        },
                        icon: const Icon(Icons.send, color: Colors.white70,))
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    }
    else {

      //User message
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      //bot response
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));

      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

}
