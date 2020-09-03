import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:showsomelove/utils/contains_test_object.dart';

class StorageService {
  final FirebaseStorage fbStorage;

  StorageService({FirebaseStorage fbStorage})
      : assert(containsTestObject(fbStorage),
            'Tests require a mock FirebaseStorage object.'),
        this.fbStorage = fbStorage ?? FirebaseStorage.instance;

  Future<String> uploadToFirebase(File image) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

    final storageRef = this.fbStorage.ref().child(fileName);
    final uploadTask = storageRef.putFile(image);
    final storageSnapshot = await uploadTask.onComplete;
    final downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      return downloadUrl.toString();
    }

    return null;
  }
}
