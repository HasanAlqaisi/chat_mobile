class Seen {
  String userId;
  String username;
  String? image;
  String seenDate;

  Seen({
    required this.userId,
    required this.username,
    this.image,
    required this.seenDate,
  });

  Seen copyWith({
    String? userId,
    String? username,
    String? image,
    String? seenDate,
  }) {
    return Seen(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      image: image ?? this.image,
      seenDate: seenDate ?? this.seenDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'image': image,
      'seenDate': seenDate,
    };
  }

  factory Seen.fromMap(Map<String, dynamic> map) {
    return Seen(
      userId: map['userId'] as String,
      username: map['username'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      seenDate: map['seenDate'] as String,
    );
  }

  @override
  String toString() {
    return 'Seens(userId: $userId, username: $username, image: $image, seenDate: $seenDate)';
  }

  @override
  bool operator ==(covariant Seen other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.username == username &&
        other.image == image &&
        other.seenDate == seenDate;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        username.hashCode ^
        image.hashCode ^
        seenDate.hashCode;
  }
}
