import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spaceflight_news/articles/models/article.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({
    super.key,
    required this.article,
    required this.function,
  });

  final Article article;
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
          child: Row(
            children: [
              Container(
                height: 90.0,
                width: 90.0,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                ),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              ArticleInformation(article: article),
            ],
          ),
        ),
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
