import 'dart:convert';

List<Tasks> tasksFromJson(String str) =>
    List<Tasks>.from(json.decode(str).map((x) => Tasks.fromJson(x)));

String tasksToJson(List<Tasks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasks {
  Tasks({
    this.id,
    this.title,
    this.createdAt,
  });

  int id;
  String title;
  DateTime createdAt;

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "createdAt": createdAt.toIso8601String(),
      };
}
