import 'package:flutter/material.dart';
import 'package:todo_app/no_glow_behaviour.dart';
import 'package:todo_app/screen/taskpage.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/widget.dart';
import 'package:todo_app/models/task.dart';

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
                      child: FutureBuilder(
                        future: DatabaseHelper.instance.getTasks(),
                        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
                          if(!snapshot.hasData){
                            return Center(child: Text('Loading..'),);
                          }
                          return ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap: (){
                                   Navigator.push(context, MaterialPageRoute(
                                     builder: (context) => TaskPage(task: snapshot.data![index])
                                   ),).then((value) => setState((){}));
                                  },
                                  child: TaskCard(
                                    title: snapshot.data![index].title,
                                    desc: snapshot.data![index].desc,
                                  ),
                                );
                              }

                            ),
                          );
                        },
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
                        builder: (context) => TaskPage(task: null),),
                    ).then((value){
                      setState(() {});
                    });
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
