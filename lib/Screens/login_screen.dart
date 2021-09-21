import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tria/resources/auth_methods.dart';
import 'package:tria/utils/universal_variables.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  bool isLoginPressed = false;
  double rateZero = 0;
  double rateOne = 0;
  double rateTwo = 0;
  double rateThree = 0;
  double rateFour = 0;
  double rateFive = 0;
  double rateSix = 0;
  double rateSeven = 0;
  double rateEight = 0;
  double rateNine = 0;
  double rateTen = 0;
  double rateEleven = 0;
  double rateTwelve = 0;
  String asset;
  double top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: UniversalVariables.blackColor,

      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            //only if scroll update notification is triggered
            setState(() {
              rateTwelve -= v.scrollDelta / 5.5;
              rateEleven -= v.scrollDelta / 1.5;
              rateTen -= v.scrollDelta / 2;
              rateNine -= v.scrollDelta / 2.5;
              rateEight -= v.scrollDelta / 3;
              rateSeven -= v.scrollDelta / 3.5;
              rateSix -= v.scrollDelta / 4;
              rateFive -= v.scrollDelta / 4.5;
              rateFour -= v.scrollDelta / 5;
              rateThree -= v.scrollDelta / 5.5;
              rateTwo -= v.scrollDelta / 6;
              rateOne -= v.scrollDelta / 6.5;
              rateZero -= v.scrollDelta / 7;
            });
          }
        },
        child: Stack(
          children: <Widget>[
            ParallaxWidget(top: rateZero, asset: "0"),
            ParallaxWidget(top: rateOne, asset: "1"),
            ParallaxWidget(top: rateTwo, asset: "2"),
            ParallaxWidget(top: rateThree, asset: "3"),
            ParallaxWidget(top: rateTwelve, asset: "12"),
            ParallaxWidget(top: rateFour, asset: "4"),
            ParallaxWidget(top: rateFive, asset: "5"),
            ParallaxWidget(top: rateSix, asset: "6"),
            ParallaxWidget(top: rateSeven, asset: "7"),
            ParallaxWidget(top: rateEight, asset: "8"),
            ParallaxWidget(top: rateNine, asset: "9"),
            ParallaxWidget(top: rateTen, asset: "10"),
            ParallaxWidget(top: rateEleven, asset: "11"),
            ListView(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, bottom: 0),
                ),
                Container(
                  child: loginButton(),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(top: 700.0),
                  color: Colors.transparent,
                ),
                isLoginPressed
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 400,
                        color: Colors.transparent,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return Shimmer.fromColors(
        baseColor: Colors.black87,
        highlightColor: UniversalVariables.senderColor,
        child: FlatButton(
          padding: EdgeInsets.all(25),
          child: Text(
            "LOGIN",
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
          ),
          onPressed: () => performLogin(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ));
  }

  void performLogin() {
    print("tring to perform login");
    setState(() {
      isLoginPressed = true;
    });
    _authMethods.signIn().then((User user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  void authenticateUser(User user) {
    _authMethods.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });
      if (isNewUser) {
        _authMethods.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key key,
    @required this.top,
    @required this.asset,
  }) : super(key: key);

  final double top;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: top,
      child: Container(
        height: 1280,
        width: 820,
        child: Image.asset("assets/$asset.png", fit: BoxFit.cover),
      ),
    );
  }
}
