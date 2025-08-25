class Articlesmodel {
  final String title;
  final String? desc;
  final String? img;

  Articlesmodel({required this.title, required this.desc, required this.img});
  factory Articlesmodel.fromJson(Map<String, dynamic> json) {
    return Articlesmodel(
      title: json['title'] ?? 'no title',
      desc: json['title'] ?? 'no desc',
      img: json['title'] ?? 'no img',
    );
  }
}
