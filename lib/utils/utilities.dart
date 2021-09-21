import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tria/enum/user_state.dart';

class Utils {
  static String getUsername(String email) {
    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String firstNameInitial = nameSplit[0][0];
    String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }

  static Future<PickedFile> getImage({@required ImageSource source}) async {
    PickedFile selectedImage = await ImagePicker().getImage(source: source);
    return compressImage(selectedImage);
  }

  static Future<PickedFile> compressImage(PickedFile imageToCompress) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File imagePicked = File(imageToCompress.path);
    int random = Random().nextInt(1000);
    Im.Image image = Im.decodeImage(imagePicked.readAsBytesSync());
    Im.copyResize(image, width: 500, height: 500);
    PickedFile imageP = PickedFile('$path/img_$random.jpg');
    File file = File(imageP.path);
    file.writeAsBytesSync(Im.encodeJpg(image, quality: 85));
    return imageP;
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;
      case UserState.Online:
        return 1;
      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
    switch (number) {
      case 0:
        return UserState.Offline;
      case 1:
        return UserState.Online;
      default:
        return UserState.Waiting;
    }
  }

  static String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = DateFormat('dd/MM/yy');
    return formatter.format(dateTime);
  }
}
