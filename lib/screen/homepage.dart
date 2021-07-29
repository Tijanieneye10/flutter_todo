import 'package:flutter/material.dart';
import 'package:todo_app/no_glow_behaviour.dart';
import 'package:todo_app/screen/taskpage.dart';
import 'package:todo_app/widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF6F6F6),
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                    child: Image(
                        image: AssetImage(
                          "assets/images/todo.jpg",
                        ),
                        width: 100),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: NoGlowBehaviour(),
                      child: ListView(
                        children: <Widget>[
                          TaskCard(
                            desc:
                                'Hello user! Welcome to TODO app, this is a default task that you can edit or delete to start using the app',
                            title: 'Get Started',
                          ),
                          TaskCard(
                            desc:
                                'Hello user! Welcome to TODO app, this is a default task that you can edit or delete to start using the app',
                            title: 'What to do',
                          ),
                          TaskCard(
                            desc:
                                'Hello user! Welcome to TODO app, this is a default task that you can edit or delete to start using the app',
                            title: 'What to do',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                right: 0.0,
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
                        gradient: LinearGradient(
                          colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0),
                        ),
                    ),
                    child: Image(image: AssetImage("assets/images/add_icon.png")),
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
