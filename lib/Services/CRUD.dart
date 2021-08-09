import 'package:cloud_firestore/cloud_firestore.dart';

import 'Database.dart';
import 'parameters.dart';

class CRUD {
  static Future createAUserHistory(UserParameters user, String date) async {
    return await Database.usersRef.add({
      "toName": user.toName,
      "toPhoneNo": user.toPhoneNo,
      "toAddress": user.toAddress,
      "toPincode": user.toPincode,
      "fromName": user.fromName,
      "fromPhoneNo": user.fromPhoneNo,
      "date": date,
      "timestamp": DateTime.now(),
    }).then(
      (docRef) async {
        await Database.usersRef.doc(docRef.id).update(
          {
            "id": docRef.id,
          },
        );
      },
    );
  }

  static Stream<QuerySnapshot> getUsers() {
    return Database.usersRef
        .orderBy(
          "timestamp",
          descending: true,
        )
        .snapshots();
  }

  static Future deleteUser(String docId) async {
    return await Database.usersRef.doc(docId).delete();
  }
}
