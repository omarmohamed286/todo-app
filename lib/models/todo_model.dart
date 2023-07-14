class TodoModel {
  final String title;
  final String id;
  final String createdAt;
  final String userId;

  TodoModel(this.title, this.id, this.createdAt, this.userId);

  factory TodoModel.fromJson(data) {
    return TodoModel(
        data['title'], data['_id'], data['createdAt'], data['userId']);
  }
}
