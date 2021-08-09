import 'dart:io';

import 'package:export_hanzala/GetX/getx_controller.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateText(File file) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        build: (context) => PDFLayout.page(file),
      ),
    );

    return saveDocument(
      name: "${DateTime.now().millisecondsSinceEpoch}.pdf",
      pdf: pdf,
    );
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$name");
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}

class PDFLayout {
  static final _getxCtrl = Get.put(MyGetXController());
  static final double dividerHeight = 30.0;

  static TextStyle detailsStyle() {
    return TextStyle(
      fontSize: 15,
      letterSpacing: 0.1,
      wordSpacing: 1,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle toFromStyle() {
    return TextStyle(
      fontStyle: FontStyle.italic,
      // fontItalic: Fontit,
      // fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }

  static Widget logo(file) {
    if (_getxCtrl.isHanzaibCollection)
      return Container(
        child: Image(
          MemoryImage(
            file.readAsBytesSync(),
          ),
        ),
        height: 250,
        width: 250,
      );
    return Text("");
  }

  static Widget page(File file) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logo(file),
          SizedBox(
            height: 20,
          ),
          Divider(height: dividerHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: PdfColors.blue,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "To : ",
                      style: toFromStyle(),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _getxCtrl.sendersName,
                      style: detailsStyle(),
                    ),
                    Text(
                      _getxCtrl.sendersAddress,
                      style: detailsStyle(),
                    ),
                    Text(
                      _getxCtrl.sendersPincode,
                      style: detailsStyle(),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Phone : ${_getxCtrl.sendersPhone}",
                      style: detailsStyle(),
                    ),
                  ],
                ),
              ),
              Text(
                _getxCtrl.pickedDate,
                style: detailsStyle(),
              ),
            ],
          ),
          Divider(height: dividerHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(""),
              Container(
                width: 200,
                // color: PdfColors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From : ",
                      style: toFromStyle(),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _getxCtrl.receiversName,
                      style: detailsStyle(),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Phone : ${_getxCtrl.receiversPhone}",
                      style: detailsStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: dividerHeight),
        ],
      ),
    );
  }
}
