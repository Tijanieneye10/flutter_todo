class Todo{
  final int? id;
  final String title;
  final int isDone;
  final int? taskId;

  Todo({  this.id, required this.title, required this.isDone, this.taskId});

  factory Todo.fromMap(Map<String, dynamic> json) => new Todo(
      id: json['id'],
      title: json['title'],
      taskId: json['taskId'],
      isDone: json['isDone']
  );

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "title": title,
      "taskId": taskId,
      "isDone": isDone,
    };
  }
}