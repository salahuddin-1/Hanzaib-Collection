import 'dart:io';

import 'package:export_hanzala/GetX/getx_controller.dart';
import 'package:export_hanzala/Homepage/homepage_screen.dart';
import 'package:export_hanzala/Services/CRUD.dart';
import 'package:export_hanzala/Services/GetLogoImageBytes.dart';
import 'package:export_hanzala/Services/parameters.dart';
import 'package:export_hanzala/Utility/show_toast.dart';
import 'package:export_hanzala/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Layout extends StatelessWidget {
  final _getxCtrl = Get.put(MyGetXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Confirm your details",
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
                // height: MediaQuery.of(context).size.height * 0.25,
                // color: Colors.blue,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Text(_getxCtrl.sendersName),
                    SizedBox(height: 10),
                    Text(_getxCtrl.sendersPhone),
                    SizedBox(height: 10),
                    Text(_getxCtrl.sendersAddress),
                    SizedBox(height: 10),
                    Text(_getxCtrl.sendersPincode),
                    SizedBox(height: 10),
                    Text(
                      _getxCtrl.pickedDate,
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
                    Text(_getxCtrl.receiversName),
                    SizedBox(height: 5),
                    Text(_getxCtrl.receiversPhone),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 50,
          ),
          GetBuilder<MyGetXController>(
            init: MyGetXController(),
            builder: (_) => Center(
              child: MaterialButton(
                minWidth: 200,
                color: Colors.black,
                textColor: Colors.white,
                onPressed: _getxCtrl.isLoading
                    ? () {}
                    : () async {
                        generatePdfandCreateUser(context);
                      },
                child: _getxCtrl.isLoading
                    ? circularProgress()
                    : Text("Generate PDF"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
                "Note : After opening a PDF file, if you wish to save it ,click on download/save in your respective PDF generating application. Otherwise the PDF will get generated but won't be saved."),
          ),
        ],
      ),
    );
  }

  Widget circularProgress() {
    return Container(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 1,
        color: Colors.white,
      ),
    );
  }

  void generatePdfandCreateUser(context) async {
    _getxCtrl.setIsLoading(true);
    File file = await GetLogoImageBytes.getImageFileFromAssets();

    final user = UserParameters(
      _getxCtrl.sendersName,
      _getxCtrl.sendersPhone,
      _getxCtrl.sendersAddress,
      _getxCtrl.sendersPincode,
      _getxCtrl.receiversName,
      _getxCtrl.receiversPhone,
    );
    CRUD
        .createAUserHistory(
      user,
      _getxCtrl.pickedDate,
    )
        .then(
      (value) async {
        await PdfApi.generateText(file).then(
          (pdfFile) {
            ShowToast.toast(
              context,
              "Success",
            );
            _getxCtrl.setIsLoading(false);

            try {
              PdfApi.openFile(pdfFile).then(
                (value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageScreen(),
                    ),
                    (route) => false,
                  );
                },
              );
            } catch (e) {
              ShowToast.toast(
                context,
                "Error",
              );
              _getxCtrl.setIsLoading(false);
            }
          },
        ).catchError(
          (err) {
            ShowToast.toast(
              context,
              "Error",
            );
            _getxCtrl.setIsLoading(false);
          },
        );
      },
    ).catchError(
      (err) {
        ShowToast.toast(
          context,
          "Error",
        );
        _getxCtrl.setIsLoading(false);
      },
    );
  }
}
