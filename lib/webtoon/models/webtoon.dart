class Webtoon {
  final String title, thumb, id;

  Webtoon.fromJason(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
