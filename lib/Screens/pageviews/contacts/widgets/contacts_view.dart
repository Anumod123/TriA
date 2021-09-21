import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tria/Screens/chatscreens/chat_screen.dart';
import 'package:tria/Screens/chatscreens/widgets/cached_image.dart';
import 'package:tria/Screens/pageviews/chats/widgets/online_dot_indicator.dart';
import 'package:tria/models/contact.dart';
import 'package:tria/models/users.dart';
import 'package:tria/resources/auth_methods.dart';
import 'package:tria/widgets/custom_tile.dart';

class ContactSView extends StatelessWidget {
  final Contact contact;
  final AuthMethods _authMethods = AuthMethods();
  ContactSView(this.contact);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users>(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Users users = snapshot.data;

          return ViewSLayout(
            contact: users,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewSLayout extends StatelessWidget {
  final Users contact;

  ViewSLayout({
    @required this.contact,
  });
  @override
  Widget build(BuildContext context) {
    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Text(
        contact?.name ?? "..",
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: Text("Tap to Chat"),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(uid: contact.uid),
          ],
        ),
      ),
    );
  }
}
