import 'package:export_hanzala/Screens/layout.dart';
import 'package:flutter/material.dart';

class Submit extends StatelessWidget {
  const Submit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 200,
      color: Colors.black,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Layout(),
          ),
        );
      },
      child: Text(
        "Submit",
      ),
    );
  }
}
