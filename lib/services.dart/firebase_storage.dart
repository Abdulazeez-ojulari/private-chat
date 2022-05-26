import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService{
   FirebaseStorageService._();
  static final instance = FirebaseStorageService._();

   UploadTask uploadImageFile(File image, String filename) {
    Reference reference = FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  
}