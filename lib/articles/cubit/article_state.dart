part of 'article_cubit.dart';

enum ArticleStatus { initial, success, failure }

class ArticleState extends Equatable {
  const ArticleState({
    this.status = ArticleStatus.initial,
    this.doGrid = true,
    this.isVisible = true,
    this.selectedArticle,
    this.articles = const [],
  });

  final ArticleStatus status;
  final bool doGrid;
  final bool isVisible;
  final Article? selectedArticle;
  final List<Article> articles;

  ArticleState copyWith({
    ArticleStatus? status,
    ValueGetter<Article?>? selectedArticle,
    List<Article>? articles,
  }) {
    return ArticleState(
      status: status ?? this.status,
      selectedArticle:
          selectedArticle != null ? selectedArticle() : this.selectedArticle,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props => [status, selectedArticle, articles];
}
