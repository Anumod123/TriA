import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tria/models/users.dart';
import 'package:tria/provider/image_upload_provider.dart';
import 'package:tria/resources/chat_methods.dart';

class StorageMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Reference _storageReference;

  //user class
  Users user = Users();

  Future<String> uploadImageToStorage(PickedFile image) async {
    // mention try catch later on

    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      File imageFile = File(image.path);
      UploadTask storageUploadTask = _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask).ref.getDownloadURL();
      // print(url);
      return url;
    } catch (e) {
      return null;
    }
  }

  void uploadImage({
    @required PickedFile image,
    @required String receiverId,
    @required String senderId,
    @required ImageUploadProvider imageUploadProvider,
  }) async {
    final ChatMethods chatMethods = ChatMethods();

    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    imageUploadProvider.setToIdle();

    chatMethods.setImageMsg(url, receiverId, senderId);
  }
}
