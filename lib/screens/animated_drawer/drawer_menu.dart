import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/final_menu_items.dart';
import '../../models/menu_item.dart';
import '../../utils/images_repo.dart';
import '../login_screen/components/login_content.dart';
import '../login_screen/login_screen.dart';
import '../on_boarding/on_boarding_home.dart';

class DrawerMenu extends StatefulWidget {
  final CustomMenuItem currentMenu;
  final ValueChanged<CustomMenuItem> onSelectedItem;
  const DrawerMenu({Key? key,required this.currentMenu, required this.onSelectedItem}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.indigoAccent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.h,top: 2.h),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      width: 10.h,
                      height: 10.h,
                      image: const AssetImage(ImagesRepo.proPic),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.h,bottom: 5.h),
                    child: const Text("SARAH JAMES"),
                  ),
                ],
              ),
            ),
            ...MenuItems.all.map(buildMenuItems).toList(),
            const Spacer(),

          ],
        ),),
      ),
    );
  }

  Widget buildMenuItems(CustomMenuItem item) =>  ListTileTheme(
    selectedColor: Colors.white,
    child: ListTile(
      minLeadingWidth: 2.h,
      leading: Icon(item.icon),
      title: Text(item.name),
      onTap: (){
        if(item.name == "Log Out"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingHome()),
          );
        } else {
          widget.onSelectedItem(item);
        }
      },
      selected: widget.currentMenu == item,
      selectedTileColor: Colors.black26,
    ),
  );
}
