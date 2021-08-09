import 'package:export_hanzala/GetX/getx_controller.dart';
import 'package:export_hanzala/Modules/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReceiverScreen extends StatelessWidget {
  ReceiverScreen({Key? key}) : super(key: key);
  final _getxCtrl = Get.put(MyGetXController());
  final _nameController = TextEditingController(text: DEFAULT_NAME);
  final _phoneController = TextEditingController(text: DEFAULT_NUMBER);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Text(
            "- - - - - - - - - - From - - - - - - - - - - ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
        GetBuilder<MyGetXController>(
          init: MyGetXController(),
          builder: (_) => Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _getxCtrl.isHanzaibCollection,
                    onChanged: (val) => onChanged(),
                    // activeColor: Colors.black,
                  ),
                  Text(
                    "Is Hanzaib Collection ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Name"),
                keyboardType: TextInputType.name,
                controller: _nameController,
                onChanged: (name) {
                  _getxCtrl.setReceiversName(name);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(hintText: "Phone no."),
                controller: _phoneController,
                onChanged: (phone) {
                  _getxCtrl.setReceiversPhone(phone);
                },
              ),
            ],
          ),
        ),
        GetBuilder<MyGetXController>(
          init: MyGetXController(),
          builder: (_) {
            return Row(
              children: [
                Text("Date :   "),
                Container(
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _getxCtrl.pickedDate.toString(),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    readOnly: true,
                    onTap: () async => showDatePickerDialog(context),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  showDatePickerDialog(context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    ).then(
      (value) {
        if (value != null) {
          final _formattedDate = DateFormat.yMMMMd().format(value);
          _getxCtrl.setDate(_formattedDate);
        }
      },
    );
  }

  void onChanged() {
    if (_getxCtrl.isHanzaibCollection) {
      _getxCtrl.setIsHanzaibCollection(false);
      _nameController.clear();
      _phoneController.clear();
      _getxCtrl.setReceiversName("");
      _getxCtrl.setReceiversPhone("");
    } else {
      _getxCtrl.setIsHanzaibCollection(true);
      _nameController.text = DEFAULT_NAME;
      _phoneController.text = DEFAULT_NUMBER;
      _getxCtrl.setReceiversName(DEFAULT_NAME);
      _getxCtrl.setReceiversPhone(DEFAULT_NUMBER);
    }
  }
}
