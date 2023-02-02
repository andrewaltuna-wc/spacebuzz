import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spaceflight_news/articles/models/article.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    super.key,
    required this.article,
    required this.doGrid,
    required this.function,
  });

  final Article article;
  final bool doGrid;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.white.withOpacity(0.8),
        child: InkWell(
          onTap: function,
          splashColor: Colors.black.withOpacity(0.3),
          child: doGrid
              ? Column(
                  children: [
                    ArticleThumbnail(doGrid: doGrid, article: article),
                    ArticleInformation(article: article),
                  ],
                )
              : Row(
                  children: [
                    ArticleThumbnail(doGrid: doGrid, article: article),
                    ArticleInformation(article: article),
                  ],
                ),
        ),
      ),
    );
  }
}

class ArticleThumbnail extends StatelessWidget {
  const ArticleThumbnail({
    super.key,
    required this.doGrid,
    required this.article,
  });

  final bool doGrid;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      width: doGrid ? double.infinity : 90.0,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
      ),
      child: CachedNetworkImage(
        imageUrl: article.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ArticleInformation extends StatelessWidget {
  const ArticleInformation({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article.newsSite,
                  style: const TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  article.formatPublishDate(),
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              article.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, height: 1.1),
            ),
          ],
        ),
      ),
    );
  }
}
