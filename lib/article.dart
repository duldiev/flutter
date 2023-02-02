// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Articles {
  List<Article> articles;

  Articles({
    required this.articles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': articles.map((x) => x.toMap()).toList(),
    };
  }

  factory Articles.fromMap(Map<String, dynamic> map) {
    return Articles(
      articles: List<Article>.from(
        (map['articles'] as List<dynamic>).map<Article>(
          (x) => Article.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Articles.fromJson(String source) =>
      Articles.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? urlToImage;
  String? publishedAt;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source?.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      source: map['source'] != null
          ? Source.fromMap(map['source'] as Map<String, dynamic>)
          : null,
      author: map['author'] != null ? map['author'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      urlToImage:
          map['urlToImage'] != null ? map['urlToImage'] as String : null,
      publishedAt:
          map['publishedAt'] != null ? map['publishedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Source {
  String? id;
  String? name;

  Source({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) =>
      Source.fromMap(json.decode(source) as Map<String, dynamic>);
}
