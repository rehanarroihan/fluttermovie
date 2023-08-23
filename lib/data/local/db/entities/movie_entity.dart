

class MovieEntity {
  String? id;
  String? title;

  MovieEntity({
    required this.id,
    required this.title
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['movie_id'] = id;
    data['title'] = title;
    return data;
  }

  MovieEntity.fromMap(Map<String, dynamic> map) {
    id = map['movie_id'];
    title = map['title'];
  }
}