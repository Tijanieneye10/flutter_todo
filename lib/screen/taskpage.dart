import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/task_widget.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  TaskPage({this.task});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  String taskTitle = "";
  String taskDesc = "";
  int? taskId = 0;

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;

  //Set visibility to check if task exists
  bool _contentVisibility = false;

  void initState() {
    if (widget.task != null) {
      taskTitle = widget.task!.title;
      taskDesc = widget.task!.desc;
      taskId = widget.task!.id;

      //Check if task is available and set visibility to true
      _contentVisibility = true;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(
                              24.0,
                            ),
                            child: Image(
                                image: AssetImage(
                                    "assets/images/back_arrow_icon.png")),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task == null) {
                                   taskId = await DatabaseHelper.instance.add(
                                    Task(title: value, desc: "No description"),
                                  );
                                  // Let update the state
                                  setState(() {
                                    _contentVisibility = true;
                                    taskTitle = value;
                                  });
                                  print('Task send successfully');
                                } else {
                                  taskId = await DatabaseHelper.instance.updateTask(
                                      Task(id: widget.task!.id, title: value, desc: "hello"),);
                                  setState(() {
                                    _contentVisibility = true;
                                    taskTitle = value;
                                  });
                                  print('Task updated successfully');
                                }
                                _descriptionFocus.requestFocus();
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Task here...",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                            controller: TextEditingController()
                              ..text = taskTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Visibility(
                        visible: _contentVisibility,
                        child: descriptionTextField(taskDesc)),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: _contentVisibility,
                      child: FutureBuilder(
                        future: DatabaseHelper.instance.getTodo(taskId),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Todo>> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text('Loading..'),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    if(snapshot.data![index].isDone == 0){
                                      await DatabaseHelper.instance.updateTodo(snapshot.data![index].id, 1);
                                    } else{
                                      await DatabaseHelper.instance.updateTodo(snapshot.data![index].id, 0);
                                    }
                                    setState(() {
                                      _contentVisibility = true;
                                    });

                                  },
                                  child: ViewTasks(
                                    isDone: snapshot.data![index].isDone,
                                    title: snapshot.data![index].title,
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisibility,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(
                              right: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: Color(0xFF86829D),
                                width: 1.5,
                              ),
                            ),
                            child: Image(
                              image: AssetImage("assets/images/check_icon.png"),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: _todoFocus,
                              controller: TextEditingController()..text = "",
                              onSubmitted: (value) async {
                                if (value != "") {
                                  if (taskId != 0) {
                                    await DatabaseHelper.instance.addTodo(
                                      Todo(
                                          title: value,
                                          isDone: 0,
                                          taskId: taskId),
                                    );
                                    setState(() {});
                                    print('Task send successfully');
                                  } else {
                                    print("something is wrong");
                                  }
                                }

                                _todoFocus.requestFocus();
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.add_task),
                                hintText: 'Enter Task here',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () async {
                    if(taskId != 0){
                      await DatabaseHelper.instance.deleteTaskandTodo(widget.task!.id);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFFFE3577)),
                    child: Image(
                        image: AssetImage("assets/images/delete_icon.png")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField descriptionTextField(String taskDesc) {
    return TextField(
      focusNode: _descriptionFocus,
      onSubmitted: (value) async {
        if(value != null){
          if(taskId != 0){
            await DatabaseHelper.instance.updateTask(
              Task(id: widget.task!.id, title: widget.task!.title, desc: value),);
              taskDesc = value;
          }
        }
        _todoFocus.requestFocus();
      },
      decoration: InputDecoration(
        hintText: "Enter Task Description here...",
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
      ),
      // controller: TextEditingController()
      //   ..text = taskDesc,
    );
  }
}

class ViewTasks extends StatefulWidget {
  final int isDone;
  final String title;

  ViewTasks({required this.isDone, required this.title});

  @override
  _ViewTasksState createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 20.0,
              height: 20.0,
              margin: EdgeInsets.only(
                right: 12.0,
                bottom: 4.0,
              ),
              decoration: BoxDecoration(
                color: widget.isDone == 1 ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: Color(0xFF86829D),
                  width: 1.5,
                ),
              ),
              child: Image(
                image: AssetImage("assets/images/check_icon.png"),
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                widget.title,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
