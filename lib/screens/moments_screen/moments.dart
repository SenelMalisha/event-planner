import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

/** created by Himashi Bogahawaththa **/
/** Eyepax IT Consulting (Pvt) Ltd **/
/** created on 1/5/2023 at 12:19 PM **/

class Moments extends StatefulWidget {
  const Moments({Key? key}) : super(key: key);

  @override
  State<Moments> createState() => _MomentsState();
}

class _MomentsState extends State<Moments> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() {
      _onScroll();
    });
    super.initState();
  }

  double _scrollOffset = 0.0;

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      print(_scrollOffset);
    });
  }

  double _layer1Speed = 0.5;
  double _layer2Speed = 0.45;
  double _layer3Speed = 0.42;
  double _layer4Speed = 0.375;
  double sunSpeed = 0.15;

  double _layer1HSpeed = 0.1;
  double _layer2HSpeed = 0.08;
  double _layer3HSpeed = 0.075;
  double _layer4HSpeed = 0.07;

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    var layoutHeight = screenSize.height * 3;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 66, 240, 210),
                  Color.fromARGB(255, 253, 244, 193),
                ]
            )
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: screenSize.height * 0.5 + (sunSpeed * _scrollOffset),
              right: screenSize.width * 0.3,
              left: 0,
              child: SvgPicture.asset('assets/images/sun.svg'),
            ),
            Positioned(
              bottom: -20 + _layer4Speed * _scrollOffset,
              right: _layer4HSpeed * _scrollOffset * -1,
              left: _layer4HSpeed * _scrollOffset * -1,
              height: screenSize.height,
              child: SvgPicture.asset(
                'assets/images/mountains-layer-4.svg',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
              bottom: -20 + _layer3Speed * _scrollOffset,
              right: _layer3HSpeed * _scrollOffset * -1,
              left: _layer3HSpeed * _scrollOffset * -1,
              height: screenSize.height,
              child: SvgPicture.asset(
                'assets/images/mountains-layer-2.svg',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
              bottom: -10 + _layer2Speed * _scrollOffset,
              right: _layer2HSpeed * _scrollOffset * -1,
              left: _layer2HSpeed * _scrollOffset * -1,
              height: screenSize.height,
              child: SvgPicture.asset(
                'assets/images/trees-layer-2.svg',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
              bottom: -20 + _layer1Speed * _scrollOffset,
              right: _layer1HSpeed * _scrollOffset * -1,
              left: _layer1HSpeed * _scrollOffset * -1,
              height: screenSize.height,
              child: SvgPicture.asset(
                'assets/images/layer-1.svg',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
              top: screenSize.height + (_layer1Speed * _scrollOffset * -1),
              right: 0,
              left: 0,
              height: screenSize.height,
              child: Container(
                  color: Colors.black,
                  child: gridView()
              ),
            ),
            Positioned.fill(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SizedBox(
                    height: layoutHeight,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget gridView() => StaggeredGridView.countBuilder(
    staggeredTileBuilder: (index) => index % 7 == 0
        ? const StaggeredTile.count(2,2)
        : const StaggeredTile.count(1,1),
    itemCount: 20,
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    itemBuilder: (context, index) => buildImageCard(index),
  );

  Widget buildImageCard(int index) => Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
    ),
    color: Colors.grey,
  );
}

