import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceflight_news/articles/cubit/article_cubit.dart';
import 'package:spaceflight_news/articles/cubit/article_view_cubit.dart';
import 'package:spaceflight_news/articles/models/article.dart';
import 'package:spaceflight_news/articles/widgets/article_item.dart';
import 'package:spaceflight_news/articles/widgets/article_item_placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spaceflight_news/constants.dart';

class ArticlesView extends StatelessWidget {
  const ArticlesView({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleViewCubit, ArticleViewState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Column(
            children: [
              _heroImage(),
              const SizedBox(height: 10.0),
              _dividerToolbar(context),
              const SizedBox(height: 10.0),
              Expanded(
                child: AnimatedOpacity(
                  opacity: state.isVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: state.doGrid
                      ? ArticleGrid(articles: articles)
                      : ArticleList(articles: articles),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _heroImage() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/heroimage.png'),
        ),
      ),
      child: _headerWidget(),
    );
  }

  Widget _headerWidget() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Text(
            APP_NAME,
            style: GoogleFonts.fredokaOne(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              shadows: const <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 20.0,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(6.0, 6.0),
                  blurRadius: 10.0,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(6.0, 6.0),
                  blurRadius: 0,
                  color: Colors.deepPurple,
                ),
                Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 0,
                  color: Colors.deepOrange,
                ),
              ],
            ),
          ),
          const Text(
            '🚀 The latest news on everything space! 🚀',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewSwitch(BuildContext context, {required bool doGrid}) {
    final articleViewCubit = context.read<ArticleViewCubit>();
    final MaterialStateProperty<Color?> thumbColor =
        MaterialStateProperty.resolveWith<Color?>(
      (_) => Colors.white,
    );
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (_) => doGrid
          ? const Icon(Icons.grid_view, color: Colors.black)
          : const Icon(Icons.list, color: Colors.black),
    );
    return Switch(
      thumbColor: thumbColor,
      thumbIcon: thumbIcon,
      value: doGrid,
      onChanged: (value) {
        articleViewCubit.toggleVisibility();
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            articleViewCubit.toggleVisibility();
            articleViewCubit.toggleView(value);
          },
        );
      },
    );
  }

  Widget _dividerToolbar(BuildContext context) {
    final articleViewCubit = context.read<ArticleViewCubit>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest news',
              style: GoogleFonts.righteous(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                // letterSpacing: 3.0,
              ),
            ),
            _viewSwitch(context, doGrid: articleViewCubit.state.doGrid),
          ],
        ),
      ),
    );
  }
}

class ArticleGrid extends StatelessWidget {
  const ArticleGrid({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return articles.isNotEmpty
        ? GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: List.generate(
              articles.length,
              (index) {
                final article = articles[index];
                return ArticleItem(
                  article: article,
                  doGrid: true,
                  function: () {
                    context.read<ArticleCubit>().articleSelected(article);
                  },
                );
              },
            ),
          )
        : GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: List.generate(
              10,
              (_) {
                return const ArticleItemPlaceholder(
                  doGrid: true,
                );
              },
            ),
          );
  }
}

class ArticleList extends StatelessWidget {
  const ArticleList({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return articles.isNotEmpty
        ? ListView.separated(
            itemBuilder: ((context, index) {
              final article = articles[index];
              return ArticleItem(
                article: article,
                doGrid: false,
                function: () {
                  context.read<ArticleCubit>().articleSelected(article);
                },
              );
            }),
            separatorBuilder: ((context, index) =>
                const SizedBox(height: 10.0)),
            itemCount: articles.length,
          )
        : ListView.separated(
            itemBuilder: ((context, index) {
              return const ArticleItemPlaceholder(
                doGrid: false,
              );
            }),
            separatorBuilder: ((context, index) =>
                const SizedBox(height: 10.0)),
            itemCount: 10,
          );
  }
}
