import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spaceflight_news/articles/cubit/article_cubit.dart';
import 'package:spaceflight_news/articles/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({super.key, required this.article});

  static Page page({required Article article}) {
    return MaterialPage<void>(
      child: ArticleDetailPage(article: article),
    );
  }

  final Article article;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ArticleCubit>().articleDeselected();
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ReturnWidget(),
            const SizedBox(height: 10.0),
            _ArticleWidget(article: article),
          ],
        ),
      ),
    );
  }
}

class _ArticleWidget extends StatelessWidget {
  const _ArticleWidget({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _newsSite(),
          _title(),
          const SizedBox(height: 5.0),
          _publishDate(),
          const SizedBox(height: 20.0),
          _image(),
          const SizedBox(height: 15.0),
          const Text(
            'Summary:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5.0),
          _summary(),
        ],
      ),
    );
  }

  Widget _newsSite() {
    return Text(
      article.newsSite,
      style: const TextStyle(
        color: Colors.white,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _title() {
    return Text(
      article.title,
      style: const TextStyle(
        height: 1.1,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  Widget _publishDate() {
    return Text(
      'Published ${article.formatPublishDate()}',
      style: const TextStyle(color: Colors.white, fontSize: 12.0),
    );
  }

  Widget _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: 150.0,
        width: double.infinity,
        color: Colors.white.withOpacity(0.2),
        child: CachedNetworkImage(
          imageUrl: article.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _summary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        // border: Border.all(color: Colors.white.withOpacity(0.3), width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        article.summary,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _ReturnWidget extends StatelessWidget {
  const _ReturnWidget();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Material(
        color: Colors.white.withOpacity(0.8),
        child: InkWell(
          onTap: () {
            context.read<ArticleCubit>().articleDeselected();
            Navigator.of(context).pop();
          },
          splashColor: Colors.black.withOpacity(0.3),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.arrow_circle_left_outlined),
                SizedBox(width: 5.0),
                Text('Continue browsing'),
                SizedBox(width: 5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
