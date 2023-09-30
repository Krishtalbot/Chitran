import 'package:chitran/custom_check_list.dart';
import 'package:chitran/map.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog({super.key, required this.name});
  final String name;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  // Define variables to track the checkbox state
  bool isChecked1 = false;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        width: 300,
        height: 250,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            Text(
              widget.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            CustomCheckList(
              title: "Do something that is better",
            ),
            SizedBox(
              height: 5,
            ),
            CustomCheckList(title: "I will but maybe or maybe not."),
            FloatingActionButton(
              onPressed: () {
                // Use Navigator to navigate to a different page
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MapPage(),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
