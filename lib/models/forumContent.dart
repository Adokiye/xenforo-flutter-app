
class ForumContent {
  String title;
  int date;
  int id;
  int viewCount;
  int replyCount;
  ForumContent({this.title, this.date, this.id, this.viewCount, this.replyCount});
   factory ForumContent.fromJson(Map<String,dynamic> json) {
    return ForumContent(
      title: json['title'],
      date: json['last_post_date'],
      id: json['thread_id'],
      viewCount: json['view_count'],
      replyCount: json['reply_count']
    );
  }
    ForumContent.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.date = map['last_post_date'];
    this.id = map['thread_id'];
    this.viewCount = map['view_count'];
    this.replyCount = map['reply_count'];
  }
}
