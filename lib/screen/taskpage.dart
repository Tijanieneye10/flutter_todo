
import 'package:flutter/material.dart';
import 'package:todo_app/task_widget.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0,),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(24.0,),
                              child: Image(
                                image: AssetImage("assets/images/back_arrow_icon.png")
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Enter Task here...",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Task Description here...",
                            border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                          ),
                      ),
                    ),

                    TaskWidget(text: "Create your first task", isDone: false,),
                    TaskWidget(text: "Create your first task", isDone: true,),
                  ],
                ),
                Positioned(
                  bottom: 20.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFFE3577)),
                      child:
                      Image(image: AssetImage("assets/images/delete_icon.png")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
