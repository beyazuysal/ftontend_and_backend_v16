import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.only(left: 15, bottom: 15),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  sectionName,
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(width: 1),
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey[600],
                    size: 15,
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
            Text(
              text,
              style:
                  TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w300),
            ),
          ],
        ));
  }
}
