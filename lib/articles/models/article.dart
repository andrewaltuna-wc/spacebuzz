import 'package:equatable/equatable.dart';
import 'package:spaceflight_news/articles/mixins/date_formatter.dart';

class Article extends Equatable with DateFormatter {
  Article({
    required this.title,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
  });

  Article.fromJson(Map json) {
    title = json['title'];
    imageUrl = json['imageUrl'];
    newsSite = json['newsSite'];
    summary = json['summary'];
    publishedAt = json['publishedAt'];
    updatedAt = json['updatedAt'];
  }

  String formatPublishDate() {
    return formatDate(publishedAt);
  }

  String formatUpdateDate() {
    return formatDate(updatedAt);
  }

  late String title, imageUrl, newsSite, summary, publishedAt, updatedAt;

  @override
  List<Object?> get props => [
        title,
        imageUrl,
        newsSite,
        summary,
        publishedAt,
        updatedAt,
      ];
}
