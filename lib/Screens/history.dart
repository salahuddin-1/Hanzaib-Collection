import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_hanzala/Screens/order.dart';
import 'package:export_hanzala/Services/CRUD.dart';
import 'package:export_hanzala/Utility/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Order history",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CRUD.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Couldn't load data"),
            );
          }
          final length = snapshot.data?.docs.length;

          if (snapshot.hasData) {
            return Container(
              child: ListView.builder(
                itemCount: length,
                itemBuilder: (context, index) {
                  final user = snapshot.data?.docs[index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetail(
                                toName: user?["toName"],
                                toPhone: user!
                                        .data()
                                        .toString()
                                        .contains("toPhoneNo")
                                    ? user["toPhoneNo"]
                                    : "",
                                toAddress: user["toAddress"],
                                toPincode: user["toPincode"],
                                fromName: user["fromName"],
                                fromPhone: user["fromPhoneNo"],
                                pickedDate: user["date"],
                              ),
                            ),
                          );
                        },
                        leading: Text("${index + 1}"),
                        title: Text(user?["toName"]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pincode : " + user?["toPincode"]),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Tap to view details",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteDialog(
                              context,
                              user?["id"],
                            );
                          },
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  deleteDialog(context, user) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete ?"),
        content: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                CRUD.deleteUser(user).then(
                  (value) {
                    ShowToast.toast(
                      context,
                      "Deleted",
                    );
                  },
                ).catchError(
                  (err) {
                    ShowToast.toast(
                      context,
                      "Error",
                    );
                  },
                );
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        ),
      ),
    );
  }
}
