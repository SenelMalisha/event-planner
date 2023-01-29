import 'package:event_planner/screens/animated_drawer/payment_page.dart';
import 'package:event_planner/screens/animated_drawer/promotion_page.dart';
import 'package:event_planner/screens/animated_drawer/rate_us_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../models/final_menu_items.dart';
import '../../models/menu_item.dart';
import 'about_us_page.dart';
import 'dashboard_page.dart';
import 'drawer_menu.dart';
import 'help_page.dart';
import 'history_page.dart';
import 'notification_page.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({Key? key}) : super(key: key);

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {

  CustomMenuItem currentMenu = MenuItems.dashboard;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 30,
        style: DrawerStyle.Style1,
        slideWidth: MediaQuery.of(context).size.width*0.7,
        showShadow: true,
        backgroundColor: Colors.black12,
        menuScreen:  Builder(
          builder: (context) {
            return DrawerMenu(
              onSelectedItem: (CustomMenuItem item) {
                setState(() {
                  currentMenu = item;
                  ZoomDrawer.of(context)!.close();
                });
              },
              currentMenu: currentMenu,);
          }
        ),
        mainScreen: getScreen());
  }
  Widget getScreen (){
    switch (currentMenu) {
      case MenuItems.payment:
        return ExpensesHome();
      case MenuItems.history:
        return const HistoryPage();
      case MenuItems.dashboard:
        return const Dashboard();
      case MenuItems.rateUs:
        return const RateUsPage();
      case MenuItems.aboutUs:
        return const AboutUsPage();
      case MenuItems.promotion:
        return const PromotionPage();
      case MenuItems.help:
        return const HelpPage();
      case MenuItems.notification:
      default:
        return const NotificationPage();

    }
  }
}
