import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sizer/sizer.dart';
import '../../utils/images_repo.dart';
import '../animated_drawer/drawer.dart';

class OnBoardingHome extends StatelessWidget {
  const OnBoardingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: IntroductionScreen(
      pages: [
        PageViewModel(
            title: "Fractional shares",
            body: "Instead of having to buy an entire share, invest any amount you want.",
            image: buildImage("assets/lottie/onboarding1.gif"),
            decoration: getPageDecoration()

        ),
        PageViewModel(
            title: "Learn as you go",
            body: "Download the Stockpile app and master the market with our mini-lesson.",
            image: buildImage("assets/lottie/onboarding2.gif"),
            decoration: getPageDecoration()
        ),
        PageViewModel(
            title: "Kids and teens",
            body: "Kids and teens can track their stocks 24/7 and place trades that you approve.",
            image: buildImage("assets/lottie/onboarding3.gif"),
            decoration: getPageDecoration()
        ),
        PageViewModel(
            title: "Full Screen Page",
            body: "Another beautiful body text for this example onboarding. Start your journey",
            image: buildImage("assets/lottie/onboarding4.gif"),
            decoration: getPageDecoration()
        ),
      ],
      done: const Text("START", style: TextStyle(fontWeight: FontWeight.w600),),
      onDone: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DrawerMain()),
        );

      },
      animationDuration: 700,
      globalBackgroundColor: Colors.white,
      showNextButton: true,
      showSkipButton: true,
      next: const Icon(Icons.arrow_forward),
      skip: const Text("SKIP"),
    ));
  }
  Widget buildImage (String path){
    return Center( child: Image.asset(path, width: 50.w,),);
  }
  PageDecoration getPageDecoration () => PageDecoration(
    titleTextStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700,color: Colors.black),
    bodyTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.black),
    imagePadding: EdgeInsets.all(3.w),
    // pageColor: Colors.indigoAccent
  );
}
