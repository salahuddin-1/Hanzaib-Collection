import 'package:export_hanzala/Modules/constant.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyGetXController extends GetxController {
  String _pickedDate = DateFormat.yMMMMd().format(DateTime.now());

  String _sendersName = "";
  String _sendersAddress = "";
  String _sendersPincode = "";
  String _sendersPhone = "";

  String _receiversName = DEFAULT_NAME;
  String _receiversPhone = DEFAULT_NUMBER;

  bool _isLoading = false;

  bool _isHanzaibCollection = true;

  String get pickedDate => _pickedDate;

  String get sendersName => _sendersName;
  String get sendersAddress => _sendersAddress;
  String get sendersPincode => _sendersPincode;
  String get sendersPhone => _sendersPhone;

  String get receiversName => _receiversName;
  String get receiversPhone => _receiversPhone;

  bool get isLoading => _isLoading;

  bool get isHanzaibCollection => _isHanzaibCollection;

  void setDate(String date) {
    _pickedDate = date;
    update();
  }

  void setSendersName(String val) {
    _sendersName = val;
  }

  void setSendersAddress(String val) {
    _sendersAddress = val;
  }

  void setSendersPincode(String val) {
    _sendersPincode = val;
  }

  void setSendersPhone(String val) {
    _sendersPhone = val;
  }

  void setReceiversName(String val) {
    _receiversName = val;
  }

  void setReceiversPhone(String val) {
    _receiversPhone = val;
  }

  void setIsLoading(bool val) {
    _isLoading = val;
    update();
  }

  void setIsHanzaibCollection(bool val) {
    _isHanzaibCollection = val;
    update();
  }
}
