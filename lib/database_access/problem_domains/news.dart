class News {
  late Source source;
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String content;
  News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  News.fromJson(Map<String, dynamic> json) {
    source = Source.fromJson(json['source']);
    author = json['author'] ?? "Unknown";
    title = json['title'] ?? "No title";
    description = json['description'] ?? "No description";
    url = json['url'];
    urlToImage = json['urlToImage'] ??
        "https://cdn.pixabay.com/photo/2017/04/03/04/48/riyadh-2197496_1280.jpg";
    publishedAt = json['publishedAt'];
    content = json['content'] ?? "No content";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['source'] = source.toJson();
    _data['author'] = author;
    _data['title'] = title;
    _data['description'] = description;
    _data['url'] = url;
    _data['urlToImage'] = urlToImage;
    _data['publishedAt'] = publishedAt;
    _data['content'] = content;
    return _data;
  }
}

class Source {
  late String id;
  late String name;
  Source({
    required this.id,
    required this.name,
  });

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "Unknown";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
