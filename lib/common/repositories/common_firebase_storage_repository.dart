import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaserStorageRepositoryProvider = Provider((ref) =>
    CommonFirebaserStorageRepository(
        firebaseStorage: FirebaseStorage.instance));

class CommonFirebaserStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaserStorageRepository({required this.firebaseStorage});

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);

    TaskSnapshot snap = await uploadTask;

    String donwloadUrl = await snap.ref.getDownloadURL();
    return donwloadUrl;
  }
}
