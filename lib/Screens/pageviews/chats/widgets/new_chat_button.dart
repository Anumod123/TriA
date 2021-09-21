import 'package:flutter/material.dart';
import 'package:tria/Screens/pageviews/chats/widgets/new_chat_list.dart';
import 'package:tria/utils/universal_variables.dart';

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              backgroundColor: UniversalVariables.blackColor,
              builder: (context) => NewChatListScreen(),
              isScrollControlled: true,
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: UniversalVariables.themeOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
    );
  }
}
