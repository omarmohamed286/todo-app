class UserModel {
  final String id;
  final String username;
  final String firstName;

  UserModel(this.id, this.username, this.firstName);

  factory UserModel.fromJson(data) {
    return UserModel(data['_id'], data['username'], data['firstName']);
  }
}
