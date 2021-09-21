import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tria/enum/user_state.dart';
import 'package:tria/models/users.dart';
import 'package:tria/resources/auth_methods.dart';
import 'package:tria/utils/utilities.dart';

class OnlineDotIndicator extends StatelessWidget {
  final String uid;
  final AuthMethods _authMethods = AuthMethods();

  OnlineDotIndicator({
    @required this.uid,
  });
  @override
  Widget build(BuildContext context) {
    getColor(int state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        default:
          return Colors.orange;
      }
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: _authMethods.getUserStream(uid: uid),
      builder: (context, snapshot) {
        Users users;

        if (snapshot.hasData && snapshot.data.data() != null) {
          users = Users.fromMap(snapshot.data.data());
        }

        return Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.only(top: 8, right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColor(users?.state),
            ),
          ),
        );
      },
    );
  }
}
