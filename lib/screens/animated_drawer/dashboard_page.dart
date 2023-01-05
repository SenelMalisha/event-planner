
import 'package:event_planner/screens/bot_screen/chat_screen.dart';
import 'package:event_planner/screens/moments_screen/moments.dart';
import 'package:flutter/material.dart';

import '../../models/personal_heighlight.dart';
import '../../utils/constants.dart';
import '../../widgets/heighlight_card.dart';
import '../../widgets/menu_widget.dart';
import '../../widgets/shift_card.dart';
import '../camera_scanner/camera_scanner.dart';
import '../note/note_grid.dart';
import '../bot_screen/bot.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isLoading = true;
  var _personalHighlights = <PersonalHighlight>[
    PersonalHighlight(
        imagePath: 'assets/images/ph1.png',
        title: 'Weekly Summary',
        detail2: 'has been completed',
        color1: kBackgroundColor,
        color2: BgColor1,
        detail1: '',
        subCategories: []),
    PersonalHighlight(
        imagePath: 'assets/images/ph2.png',
        title: 'Cash Received',
        detail2: 'On 12 Apr 2021',
        color1: kBackgroundColor,
        color2: BgColor2,
        detail1: '',
        subCategories: []),
    PersonalHighlight(
        imagePath: 'assets/images/ph4.png',
        title: 'Cash Withdraws',
        detail2: 'Pending',
        color1: kBackgroundColor,
        color2: BgColor3,
        detail1: '',
        subCategories: []),
    PersonalHighlight(
        imagePath: 'assets/images/ph3.png',
        title: 'Refer Friends & Win ',
        detail2: '*Conditions Apply',
        color1: kBackgroundColor,
        color2: BgColor4,
        detail1: 'Prizes',
        subCategories: []),
  ];

  final controller = ScrollController();
  final double itemSize = 50;

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
    Icons.monochrome_photos,
    Icons.monochrome_photos,
    Icons.monochrome_photos,
    Icons.monochrome_photos,
    Icons.monochrome_photos,
    Icons.monochrome_photos,
    Icons.monochrome_photos,
    Icons.monochrome_photos,
  ];

  final List<String> titleList = [
    "My Bot",
    "Events",
    "Alarms",
    "My Notes",
    "Moments",
    "TODO",
    "TODO",
    "TODO",
    "TODO",
    "TODO",
    "TODO",
    "TODO",
    "TODO",
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: bgDark,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotesGridView()),
          );
        },
        child: Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      backgroundColor: LinearColor4,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text("Dashboard"),
        leading: const MenuWidget(),
      ),
      body: Column(
        children: [
          // personal highlights
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  color: Colors.black,
                ),
                height: MediaQuery.of(context).size.height * 0.1986,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6, bottom: 5),
                  child: Text(
                    "Highlights",
                    style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12, top: 14),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: _personalHighlights
                        .map((e) => PersonalHighlightCard(e, _isLoading))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          // personal highlight floating cards
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 19),
            child: _body(),
          ),
        ],
      ),
    );
  }

  Widget _body() => Stack(
    children: [
      _listView(),
      Container(
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
    height: MediaQuery.of(context).size.height/2,
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
                    primary: bgDark,
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
