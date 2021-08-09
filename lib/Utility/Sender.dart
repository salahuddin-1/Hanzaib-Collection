import 'package:export_hanzala/GetX/getx_controller.dart';
import 'package:export_hanzala/Modules/sender_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SenderScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _phoneNoController = TextEditingController();

  final _getxCtrl = Get.put(MyGetXController());
  late final SenderDetails senderDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Text(
            "- - - - - - - - - - To - - - - - - - - - - ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Name"),
          keyboardType: TextInputType.name,
          controller: _nameController,
          onChanged: (name) {
            _getxCtrl.setSendersName(name);
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Phone no.",
          ),
          keyboardType: TextInputType.phone,
          maxLength: 10,
          controller: _phoneNoController,
          onChanged: (phone) {
            _getxCtrl.setSendersPhone(phone);
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Address"),
          keyboardType: TextInputType.name,
          maxLines: 3,
          controller: _addressController,
          onChanged: (add) {
            _getxCtrl.setSendersAddress(add);
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Pincode",
          ),
          keyboardType: TextInputType.phone,
          controller: _pincodeController,
          onChanged: (pin) {
            _getxCtrl.setSendersPincode(pin);
          },
        ),
      ],
    );
  }
}
