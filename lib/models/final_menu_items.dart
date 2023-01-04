
import 'package:flutter/material.dart';

import 'menu_item.dart';

class MenuItems {
  static const  dashboard = CustomMenuItem("Dashboard", Icons.dashboard_customize_rounded);
  static const  payment = CustomMenuItem("Payment", Icons.payment_rounded);
  static const notification = CustomMenuItem("Notification", Icons.notifications_active);
  static const history = CustomMenuItem("History", Icons.account_tree_outlined);
  static const  promotion = CustomMenuItem("Promotion", Icons.production_quantity_limits_rounded);
  static const help = CustomMenuItem("Help", Icons.live_help);
  static const rateUs = CustomMenuItem("Rate Us", Icons.star_rate_sharp);
  static const aboutUs = CustomMenuItem("About Us", Icons.question_answer_rounded);
  static const logOut = CustomMenuItem("Log Out", Icons.logout_rounded);

  static const all = <CustomMenuItem> [dashboard,payment,notification,history,promotion,help,rateUs,aboutUs,logOut];
}