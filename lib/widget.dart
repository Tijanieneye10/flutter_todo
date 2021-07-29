import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String desc;

  TaskCard({ required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 34.0,
      ),
      // width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              color: Color(0xFF211551),
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF86829D),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
