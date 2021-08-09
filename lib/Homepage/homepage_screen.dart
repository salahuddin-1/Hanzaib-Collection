import 'package:export_hanzala/GetX/getx_controller.dart';
import 'package:export_hanzala/Modules/constant.dart';
import 'package:export_hanzala/Screens/history.dart';
import 'package:export_hanzala/Utility/Receiver.dart';
import 'package:export_hanzala/Utility/Sender.dart';
import 'package:export_hanzala/Utility/Submit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _getxCtrl = Get.put(MyGetXController());

  @override
  void initState() {
    super.initState();
    _getxCtrl.setReceiversName(DEFAULT_NAME);
    _getxCtrl.setReceiversPhone(DEFAULT_NUMBER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/logo.png"),
            ),
          ),
        ),
        // centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Icon(Icons.settings),
            ),
            ListTile(
              title: Text(
                "History",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          children: [
            Center(
              child: Column(
                children: [
                  SenderScreen(),
                  ReceiverScreen(),
                  SizedBox(
                    height: 50,
                  ),
                  Submit(),
                  // Container(
                  //   child: ElevatedButton(
                  //     child: Text('Click'),
                  //     onPressed: () {
                  //       getImage();
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
