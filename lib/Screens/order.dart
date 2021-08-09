import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_hanzala/GetX/getx_controller.dart';
import 'package:export_hanzala/Services/CRUD.dart';
import 'package:export_hanzala/Services/parameters.dart';
import 'package:export_hanzala/pdf_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetail extends StatelessWidget {
  late final String toName;
  late final String toPhone;
  late final String toAddress;
  late final String toPincode;
  late final String fromName;
  late final String fromPhone;
  late final String pickedDate;

  OrderDetail({
    required this.toName,
    required this.toPhone,
    required this.toAddress,
    required this.toPincode,
    required this.fromName,
    required this.fromPhone,
    required this.pickedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Order Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 30,
          left: 25,
          right: 25,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "To",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(this.toName),
                    SizedBox(height: 10),
                    (this.toPhone == "")
                        ? SizedBox.shrink()
                        : Text(this.toPhone),
                    (this.toPhone == "")
                        ? SizedBox.shrink()
                        : SizedBox(height: 10),
                    Text(this.toAddress),
                    SizedBox(height: 10),
                    Text(this.toPincode),
                    SizedBox(height: 10),
                    Text(
                      this.pickedDate.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(this.fromName),
                    SizedBox(height: 5),
                    Text(this.fromPhone),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 50,
          ),
          // Center(
          //   child: MaterialButton(
          //     minWidth: 200,
          //     color: Colors.black,
          //     textColor: Colors.white,
          //     onPressed: () async {
          //       final user = UserParameters(
          //         _getxCtrl.sendersName,
          //         _getxCtrl.sendersAddress,
          //         _getxCtrl.sendersPincode,
          //         _getxCtrl.receiversName,
          //         _getxCtrl.receiversPhone,
          //       );
          //       CRUD.createAUserHistory(user).then((value) {
          //         print('Success');
          //       });
          //     },
          //     child: Text(
          //       'Generate PDF',
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
