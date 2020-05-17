
class ForumContent {
  String title;
  int date;
  int id;
  ForumContent({this.title, this.date, this.id});
   factory ForumContent.fromJson(Map<String,dynamic> json) {
    return ForumContent(
      title: json['title'],
      date: json['last_post_date'],
      id: json['thread_id']
    );
  }
      ForumContent.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.date = map['last_post_date'];
    this.id = map['thread_id'];
  }
}
