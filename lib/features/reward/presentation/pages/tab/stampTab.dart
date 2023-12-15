import 'package:flutter/material.dart';

class stampTab extends StatelessWidget {
  stampTab({super.key});
  int countStamp = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              "My Stamps"),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 5,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(25.0),
          // ),
          color: Color(0XFF20941C),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.local_drink),
                  title: Text("Stamp : ${countStamp} / 10"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
