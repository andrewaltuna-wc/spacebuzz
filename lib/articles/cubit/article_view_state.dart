part of 'article_view_cubit.dart';

class ArticleViewState extends Equatable {
  const ArticleViewState({
    this.doGrid = true,
    this.isVisible = true,
  });

  final bool doGrid, isVisible;

  ArticleViewState copyWith({bool? doGrid, bool? isVisible}) {
    return ArticleViewState(
      doGrid: doGrid ?? this.doGrid,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object> get props => [doGrid, isVisible];
}
