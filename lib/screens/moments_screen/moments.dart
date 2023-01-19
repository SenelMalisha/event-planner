import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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

  final List<String> momentsImages = [
    "assets/images/cimg1.webp",
    "assets/images/cimg2.jpg",
    "assets/images/cimg3.jpg",
    "assets/images/cimg4.jpg",
    "assets/images/cimg5.jpg",
    "assets/images/cimg6.jpg",
    "assets/images/cimg7.webp",
    "assets/images/cimg10.jpg",
    "assets/images/cimg9.jpg",
    "assets/images/cimg8.jpg",
  ];

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
    var layoutHeight = screenSize.height;

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
              height: screenSize.height  * 6,
              child: Container(
                  color: Colors.black,
                  child: Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "... Moments ...",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 5
                        ),
                        textAlign: TextAlign.center,
                      )
                  )
              ),
            ),
            Positioned(
              top: screenSize.height + (_layer1Speed * _scrollOffset * -1),
              right: 0,
              left: 0,
              height: screenSize.height * 6,
              child: Container(
                padding: EdgeInsets.only(top: 50),
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(15),
                      child: gridView()
                  )
              ),
            ),
            Positioned.fill(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SizedBox(
                    height: layoutHeight * 5,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget gridView() => AnimationLimiter(
    child: StaggeredGridView.countBuilder(
      staggeredTileBuilder: (index) => index % 7 == 0
          ? const StaggeredTile.count(2,2)
          : const StaggeredTile.count(1,1),
      itemCount: 10,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemBuilder: (context, index) => buildImageCard(index),
    ),
  );

  Widget buildImageCard(int index) => Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
    ),
    color: Colors.transparent,
    child: AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 3,
      child: ScaleAnimation(
        duration: Duration(milliseconds: 4000),
        child: FadeInAnimation(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                  image: AssetImage(
                    momentsImages[index],
                  ),
                  fit: BoxFit.cover),
                boxShadow: const [
                  BoxShadow(color: Colors.white30, blurRadius: 1, spreadRadius: 2, blurStyle: BlurStyle.outer),
                  BoxShadow(color: Colors.white30, blurRadius: 1, spreadRadius: 2, blurStyle: BlurStyle.inner),
                ],
            ),
          ),
        ),
      ),
    ),
  );
}

