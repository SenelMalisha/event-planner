
import 'package:event_planner/screens/bot_screen/chat_screen.dart';
import 'package:event_planner/screens/moments_screen/moments.dart';
import 'package:flutter/material.dart';

import '../../widgets/menu_widget.dart';
import '../bot_screen/bot.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = ScrollController();
  final double itemSize = 75;

  final screens = [
    ChatScreen(),
    ChatScreen(),
    ChatScreen(),
    Moments(),
    ChatScreen(),
    Moments(),
    ChatScreen(),
    Moments(),
    ChatScreen(),
    Moments(),
    ChatScreen(),
    ChatScreen(),
    ChatScreen(),
    ChatScreen(),
    ChatScreen(),
  ];

  final icons = [
    Icons.message_sharp,
    Icons.event,
    Icons.alarm,
    Icons.menu_book,
    Icons.monochrome_photos,

    Icons.message_sharp,
    Icons.event,
    Icons.alarm,
    Icons.menu_book,
    Icons.monochrome_photos,
    
    Icons.message_sharp,
    Icons.event,
    Icons.alarm,
    Icons.menu_book,
    Icons.monochrome_photos
  ];

  final List<String> titleList = [
    "My Bot",
    "Events",
    "Alarms",
    "My Notes",
    "Moments",

    "My Bot",
    "Events",
    "Alarms",
    "My Notes",
    "Moments",
    "My Bot",
    "Events",
    "Alarms",
    "My Notes",
    "Moments",
  ];

  void onListenerController(){
    setState(() {

    });
  }

  @override
  void initState() {
    controller.addListener(onListenerController);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onListenerController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: const Text("Dashboard"),
        leading: const MenuWidget(),
      ),
      body: _body(),
    );
  }

  Widget _body() => Stack(
    children: [
      _listView(),
      Container(
        height: 180,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white]
            )
        ),
      )
    ],
  );

  Widget _listView() => SizedBox(
    height: MediaQuery.of(context).size.height,
    child: ListView.builder(
      itemCount: titleList.length,
      controller: controller,
      itemBuilder:(context, index) {
        final itemOffset = index*itemSize;
        final difference = controller.offset-itemOffset;
        final percent = 1-(difference/(itemSize/2));

        double opacity = percent;
        double scale = percent;

        if(opacity > 1.0) opacity = 1.0;
        if(opacity < 0.0) opacity = 0.0;
        if(scale > 1.0) scale = 1.0;

        return Opacity(
          opacity: opacity,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(scale,1.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: itemSize,
              margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 2)
                  ]
              ),
              child: ElevatedButton(
                child: Container(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    children: [
                      Icon(icons[index]),
                      Container(
                        width: 40,
                      ),
                      Expanded(
                        child: Text(
                          titleList[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screens[index]),
                  );
                  print('$index');
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold)
                ),
              )
            ),
          ),
        );
      },
    ),
  );
}