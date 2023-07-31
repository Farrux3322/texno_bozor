import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:texno_bozor/utils/ui_utils/loading_dialog.dart';

Future<String?> uploadImageToFirebase(File? imageFile) async {
  if (imageFile == null) return null;

  try {
    // Create a unique filename for the image using the current timestamp
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Reference to the Firebase Storage bucket
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    // Upload the image to Firebase Storage
    await ref.putFile(File(imageFile.path));

    // Get the download URL of the uploaded image
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

Future<XFile?> pickImage() async {
  final picker = ImagePicker();
  XFile? pickedFile;

  try {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
  } catch (e) {
    print('Error picking image: $e');
  }

  return pickedFile;
}
