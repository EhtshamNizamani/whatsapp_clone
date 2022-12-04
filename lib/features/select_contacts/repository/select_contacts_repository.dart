import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/model/user_model.dart';

import '../../chat/screen/mobile_chat_screen.dart';

final selectContactRepositoryProvider = Provider((ref) {
  return SelectContactRepository(firestore: FirebaseFirestore.instance);
});

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contact = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        contact = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return contact;
  }

  void selectContact(BuildContext context, Contact selectContact) async {
    bool isFound = false;
    try {
      var userCollection = await firestore.collection('users').get();

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());

        String selectPhoneNum = selectContact.phones[0].number.replaceAll(
          ' ',
          '',
        );
        if (selectPhoneNum == userData.phoneNumber) {
          isFound = true;

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, MobileChatScreen.routeName,
              arguments: {'name': userData.name, 'uid': userData.uid});
        }
      }
      if (!isFound) {
        showSnackBar(
            context: context,
            content: 'This Number dose not Exist on this App');
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
