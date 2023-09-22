class TaskModel {
  String id;
  String title;
  String description;
  bool state;
  int date;

  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.state,
    required this.date,
  });

  TaskModel.fromJson(Map<String , dynamic> json)
      :this(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    state: json["state"],
    date: json["date"],
  );

   Map<String , dynamic> toJson(){
    return {
      "id": id,
      "title": title,
      "description": description,
      "state": state,
      "date": date,
    };
  }
}