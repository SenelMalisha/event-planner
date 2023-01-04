import 'package:flutter/material.dart';

import '../../models/personal_heighlight.dart';
import '../../utils/constants.dart';
import '../../widgets/heighlight_card.dart';
import '../../widgets/menu_widget.dart';
import '../../widgets/shift_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isLoading = true;
  var _personalHighlights = <PersonalHighlight>[
    PersonalHighlight(imagePath: 'assets/images/ph1.png', title: 'Weekly Summary', detail2: 'has been completed', color1: kBackgroundColor, color2: BgColor1, detail1: '', subCategories: []),
    PersonalHighlight(imagePath: 'assets/images/ph2.png', title: 'Cash Received', detail2: 'On 12 Apr 2021', color1: kBackgroundColor, color2: BgColor2, detail1: '', subCategories: []),
    PersonalHighlight(imagePath: 'assets/images/ph4.png', title: 'Cash Withdraws', detail2: 'Pending', color1: kBackgroundColor, color2: BgColor3, detail1: '', subCategories: []),
    PersonalHighlight(
        imagePath: 'assets/images/ph3.png', title: 'Refer Friends & Win ', detail2: '*Conditions Apply', color1: kBackgroundColor, color2: BgColor4, detail1: 'Prizes', subCategories: []),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
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
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  color: Colors.black,
                ),
                height: MediaQuery.of(context).size.height * 0.1986,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6, bottom: 5),
                  child: Text(
                    "Highlights",
                    style: TextStyle(color: whiteColor, fontWeight: FontWeight.w700, fontSize: 15),
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
                    children: _personalHighlights.map((e) => PersonalHighlightCard(e, _isLoading)).toList(),
                  ),
                ),
              ),

            ],
          ),
          // personal highlight floating cards
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 19),
            child: NextShiftCard(_isLoading,null, null, null),
          ),

        ],
      ),
    );
  }
}