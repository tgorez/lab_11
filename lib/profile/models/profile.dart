class Profile {
  final int userId;
  final int id;
  final String title;
  final String body;

  Profile({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}