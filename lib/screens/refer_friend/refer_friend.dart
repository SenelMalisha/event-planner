import 'package:clipboard/clipboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ReferAFriendView extends StatefulWidget {
  const ReferAFriendView();
  @override
  _ReferAFriendViewState createState() => _ReferAFriendViewState();
}

class _ReferAFriendViewState extends State<ReferAFriendView> {
  final String storeName = '701 Allerton';
  final String storeCode = '336074';
  final String franchiseName = 'Kings Point Ventures (KPV) DD';
  var _isLoading = true;
  Map? _referralData;
  String? _message;
  String? _url;

  @override
  void initState() {
    _getInitialData();
    super.initState();
  }

  void _getInitialData() async {
   // _referralData = await WorkPortalService.getReferralCode();
    if (_referralData != null) {
      _message = _referralData!['content'];
      _url = _referralData!['referal_link'];
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String code = "JRT00234";
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          "Refer a Friend",
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
       // leading: ToggleDrawerButton(),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/images/refer1.png",
              height: MediaQuery.of(context).size.height * 0.329,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.465,
              decoration: BoxDecoration(boxShadow: [BoxShadow(color: DropColor, offset: Offset(0, 10), blurRadius: 20)], color: whiteColor, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.049),
                    child: GestureDetector(
                        onTap: () {
                          if (_url != null) {
                            //FlutterClipboard.copy(_url!).then((value) => commonAlertPopup('Copied to clipboard'));
                          }
                        },
                        child: buildRoundedRectBorderWidget(context, code)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01228, bottom: MediaQuery.of(context).size.height * 0.0356),
                    child: Text("Touch the code to copy",
                        style: TextStyle(
                          color: TitleColor1,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.0613, right: MediaQuery.of(context).size.width * 0.0613),
                    child: Center(
                      child: Text("Share your referral code with your friends and win exciting bonus gifts and perks.",
                          style: TextStyle(
                            color: blackColor1,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.08, MediaQuery.of(context).size.height * 0.0491, MediaQuery.of(context).size.width * 0.08, 0),
                    child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ))),
                      onPressed: _isLoading
                          ? null
                          : () {
                        if (_message != null) {
                          _message = _message!.replaceAll('<br/>', '\n');
                          _message = _message!.replaceAll('\\n', '\n');
                         // Share.share(_message!);
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [LinearColor1, LinearColor2],
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          height: 49,
                          width: MediaQuery.of(context).size.width,
                          child: _isLoading
                              ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Center(
                            child: Text(
                              "Share Code",
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRoundedRectBorderWidget(context, String code) {
    return DottedBorder(
      color: Ocean4,
      strokeWidth: 2,
      borderType: BorderType.RRect,
      dashPattern: [8, 4],
      radius: Radius.circular(10),
      // padding: EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.72,
          height: MediaQuery.of(context).size.height * 0.098,
          // color: Colors.amber,
          child: Center(
            child: Text(code,
                style: TextStyle(
                  color: Ocean4,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                )),
          ),
        ),
      ),
    );
  }
}
