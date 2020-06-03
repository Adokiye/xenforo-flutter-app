import 'user.dart';
class ForumContent {
  String title;
  int date;
  int id;
  int viewCount;
  int replyCount;
  User user;
  ForumContent({this.title, this.date, this.id, this.viewCount, this.replyCount,
  this.user});
   factory ForumContent.fromJson(Map<String,dynamic> json) {
    return ForumContent(
      title: json['title'],
      date: json['last_post_date'],
      id: json['thread_id'],
      viewCount: json['view_count'],
      replyCount: json['reply_count'],
      user: json['User']
    );
  }
    ForumContent.fromMap(Map<String, dynamic> map) {
    print('content');
    print(map['User']);
    this.title = map['title'];
    this.date = map['last_post_date'];
    this.id = map['thread_id'];
    this.viewCount = map['view_count'];
    this.replyCount = map['reply_count'];
    this.user = User.fromMap(map['User']);
  }
}
