import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:spaceflight_news/articles/models/article.dart';
import 'package:http/http.dart' as http;

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit({required this.httpClient}) : super(const ArticleState());

  final http.Client httpClient;

  void articleSelected(Article article) {
    emit(state.copyWith(selectedArticle: () => article));
  }

  void articleDeselected() {
    emit(state.copyWith(selectedArticle: () => null));
  }

  Future<void> onArticlesFetched() async {
    try {
      if (state.status == ArticleStatus.initial) {
        final articles = await _fetchArticles();
        return emit(
          state.copyWith(
            status: ArticleStatus.success,
            articles: articles,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: ArticleStatus.failure));
    }
  }

  Future<List<Article>> _fetchArticles() async {
    final response = await httpClient.get(
      Uri.https(
        'api.spaceflightnewsapi.net',
        '/v3/articles',
        {'_limit': '20'},
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Article.fromJson(json);
      }).toList();
    }
    throw Exception('Error fetching articles');
  }
}
