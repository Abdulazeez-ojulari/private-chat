import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:privatechat/services.dart/firebase_storage.dart';

abstract class Storage{
   Future<UploadTask> uploadImageFile(File image, String filename);
   Future<File> getImage();
}


class FirestoreStorage implements Storage{

  final _storageService = FirebaseStorageService.instance;

  @override
  Future<File> getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    File? imageFile;
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else{
      
    }

    return imageFile!;
  }

  @override
  Future<UploadTask> uploadImageFile(File image, String filename) async =>  _storageService.uploadImageFile(image, filename);

}