
class User {
  String username;
  int registerDate;
  int lastSeen;
  int id;
  int reactionScore;
  int messageCount;
  User({this.username, this.registerDate, this.id, this.reactionScore, this.messageCount,
  this.lastSeen});
   factory User.fromJson(Map<String,dynamic> json) {
    return User(
      username: json['username'],
      registerDate: json['register_date'],
      id: json['user_id'],
      reactionScore: json['reaction_score'],
      messageCount: json['nessage_count'],
      lastSeen: json['last_activity'],
    );
  }
    User.fromMap(Map<String, dynamic> map) {
    this.username = map['username'];
    this.registerDate = map['register_date'];
    this.id = map['user_id'];
    this.reactionScore = map['reaction_score'];
    this.messageCount = map['message_count'];
    this.lastSeen = map['last_activity'];
  }
}
