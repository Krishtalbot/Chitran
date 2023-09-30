import 'package:flutter/material.dart';

class CustomCheckList extends StatefulWidget {
  CustomCheckList({super.key, required this.title});
  String title;

  @override
  State<CustomCheckList> createState() => _CustomCheckListState();
}

class _CustomCheckListState extends State<CustomCheckList> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
        },
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        border: Border.all(color: Colors.black, width: 0.1)),
                  ),
                  isChecked
                      ? Icon(
                          Icons.check,
                          size: 13,
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    color: isChecked ? Colors.grey : Colors.black,
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    letterSpacing: 0.5,
                    fontSize: 14),
              )
            ],
          ),
        ));
  }
}
