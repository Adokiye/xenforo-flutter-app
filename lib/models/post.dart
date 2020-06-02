import 'forumContent.dart';
class Post {
  String message;
  int date;
  int editDate;
  int id;
  int reactionScore;
  int attachCount;
  ForumContent forum;
  Post({this.message, this.date, this.id, this.reactionScore, this.attachCount, this.editDate,
  this.forum});
   factory Post.fromJson(Map<String,dynamic> json) {
    return Post(
      message: json['message'],
      date: json['post_date'],
      editDate: json['last_edit_date'],
      id: json['post_id'],
      reactionScore: json['reaction_count'],
      attachCount: json['attach_count'],
      forum: json['Thread']
    );
  }
    Post.fromMap(Map<String, dynamic> map) {
    this.message = map['message'];
    this.date = map['post_date'];
    this.editDate = map['last_edit_date'];
    this.id = map['post_id'];
    this.reactionScore = map['reaction_count'];
    this.forum = map['Thread'];
    this.attachCount = map['attach_count'];
  }
}
