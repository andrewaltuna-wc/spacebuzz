import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spaceflight_news/articles/cubit/article_view_cubit.dart';
import 'package:spaceflight_news/articles/models/article.dart';
import 'package:spaceflight_news/articles/view/articles_view.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key, required this.articles});
  static Page page({required List<Article> articles}) {
    return MaterialPage<void>(
      child: ArticlesPage(
        articles: articles,
      ),
    );
  }

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ArticleViewCubit(),
      child: ArticlesView(articles: articles),
    );
  }
}
