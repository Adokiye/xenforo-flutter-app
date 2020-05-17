
class Forum {
  String title;
  String description;
  int id;

  Forum({this.title, this.id, this.description});

   factory Forum.fromJson(Map<String,dynamic> json) {
    return Forum(
      title: json['title'],
      id: json['id'],
      description: json['description']
    );
  }
    Forum.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.description = map['description'];
    this.id = map['node_id'];
  }
    Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['description'] = description;
    map['id'] = id;
    return map;
  }
}
