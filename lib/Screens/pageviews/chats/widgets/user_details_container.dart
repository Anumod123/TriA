//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tria/Screens/chatscreens/widgets/cached_image.dart';
import 'package:tria/Screens/login_screen.dart';
import 'package:tria/Screens/pageviews/chats/widgets/shimmering_logo.dart';
import 'package:tria/models/users.dart';
import 'package:tria/provider/user_provider.dart';
import 'package:tria/resources/auth_methods.dart';
import 'package:tria/utils/universal_variables.dart';
import 'package:tria/widgets/appbar.dart';

class UserDetailsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut();
      if (isLoggedOut) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }

    return Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            CustomAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
              centerTitle: true,
              title: Text("Profile"),
              actions: <Widget>[
                FlatButton(
                  color: UniversalVariables.themeOrange,
                  onPressed: () => signOut(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
            UserDetailsBody(),
          ],
        ));
  }
}

class UserDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final Users users = userProvider.getUser;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          CachedImage(
            users.profilePhoto,
            isRound: true,
            radius: 200,
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  users.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  users.email,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
