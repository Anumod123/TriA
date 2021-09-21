import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tria/Screens/callscreens/pickup/pickup_layout.dart';
import 'package:tria/Screens/pageviews/chats/widgets/quiet_box.dart';
import 'package:tria/Screens/pageviews/contacts/widgets/contacts_view.dart';
import 'package:tria/models/contact.dart';
import 'package:tria/provider/user_provider.dart';
import 'package:tria/resources/chat_methods.dart';
import 'package:tria/utils/universal_variables.dart';
import 'package:tria/widgets/tria_appbar.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: TriaAppBar(
          title: Text("Contacts"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: ContactListContainer(),
        ),
      ),
    );
  }
}

class ContactListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.docs;

              if (docList.isEmpty) {
                return QuietBox(
                  heading: "This is where all the contacts are listed",
                  subtitle:
                      "Search for your friends and family to start calling or chatting with them",
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data());
                  return ContactSView(contact);
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
