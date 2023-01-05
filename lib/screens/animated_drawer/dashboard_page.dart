import 'package:flutter/material.dart';

import '../../widgets/menu_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = ScrollController();
  final double itemSize = 150;

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
      itemCount: 20,
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
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.tealAccent, blurRadius: 1, spreadRadius: 2)
                  ]
              ),
              child: Text('$index', style: const TextStyle(color: Colors.white, fontSize: 45),),
            ),
          ),
        );
      },
    ),
  );
}