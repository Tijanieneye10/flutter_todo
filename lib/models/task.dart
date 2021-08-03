class Task{

  final int? id;
  final String title;
  final String desc;

  Task({ this.id, required this.title, required this.desc});

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
    id: json['id'],
    title: json['title'],
    desc: json['desc']
  );

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "title": title,
      "desc": desc,
    };
  }

}