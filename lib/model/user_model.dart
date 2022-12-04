class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final String phoneNumber;
  final bool isOnline;
  final List<String> groupId;

  UserModel(
      {required this.groupId,
      required this.isOnline,
      required this.name,
      required this.phoneNumber,
      required this.profilePic,
      required this.uid});

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'isOnline': isOnline,
      'name': name,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'uid': uid
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        groupId: List<String>.from(map['groupId']),
        isOnline: map['isOnline'] ?? false,
        name: map['name'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        profilePic: map['profilePic'] ?? '',
        uid: map['uid'] ?? '');
  }
}
