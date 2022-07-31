import 'dart:convert';

class User {
  final String id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String phoneNumber;
  final String? profileImage;
  final String lastVisibleDate;

  User({
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    required this.phoneNumber,
    this.profileImage,
    required this.lastVisibleDate,
  });

  User copyWith({
    String? id,
    String? username,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImage,
    String? lastVisibleDate,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      lastVisibleDate: lastVisibleDate ?? this.lastVisibleDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'lastVisibleDate': lastVisibleDate,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      username: map['username'] as String,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      lastVisibleDate: map['lastVisibleDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, username: $username, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, profileImage: $profileImage, lastVisibleDate: $lastVisibleDate)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.profileImage == profileImage &&
        other.lastVisibleDate == lastVisibleDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        profileImage.hashCode ^
        lastVisibleDate.hashCode;
  }
}
