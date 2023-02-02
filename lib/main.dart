import 'package:flutter/material.dart';
import 'package:spaceflight_news/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spaceflight_news/articles/cubit/article_cubit.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    BlocProvider(
      create: (_) =>
          ArticleCubit(httpClient: http.Client())..onArticlesFetched(),
      child: const App(),
    ),
  );
}
