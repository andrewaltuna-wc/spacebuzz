import 'package:flutter/material.dart';
import 'package:spaceflight_news/articles/mixins/date_formatter.dart';

class ArticleListPlaceholder extends StatelessWidget with DateFormatter {
  const ArticleListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white.withOpacity(0.8),
        child: Row(
          children: [
            Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        TextPlaceholder(height: 10, width: 30),
                        TextPlaceholder(height: 10, width: 30),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const TextPlaceholder(height: 15),
                    const SizedBox(height: 2),
                    const TextPlaceholder(height: 15, width: 200),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextPlaceholder extends StatelessWidget {
  const TextPlaceholder({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
