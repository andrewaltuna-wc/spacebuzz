import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:spaceflight_news/articles/cubit/article_cubit.dart';
import 'package:spaceflight_news/articles/view/article_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spaceflight_news/articles/view/articles_page.dart';
import 'package:spaceflight_news/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  List<Page> onGeneratePages(ArticleState state, List<Page> pages) {
    final selectedArticle = state.selectedArticle;
    return [
      ArticlesPage.page(articles: state.articles),
      if (selectedArticle != null)
        ArticleDetailPage.page(article: selectedArticle)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
            child: FlowBuilder(
              state: context.watch<ArticleCubit>().state,
              onGeneratePages: onGeneratePages,
            ),
          ),
        ),
      ),
    );
  }
}
