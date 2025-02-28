import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:book_app/models/book.dart';
import 'package:book_app/screens/book_detail_screen.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  const BookListItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: SizedBox(
          width: 80,
          height: 120,
          child: CachedNetworkImage(
            imageUrl: book.formats['image/jpeg'] ?? '',

            fit: BoxFit.fitHeight,
            placeholder:
                (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget:
                (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.book, size: 40, color: Colors.grey[600]),
                ),
          ),
        ),
        title: Text(
          book.title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.authors.map((a) => a.name).join(', '),
              style: TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              '${book.downloadCount} Unduhan',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(bookId: book.id),
            ),
          );
        },
      ),
    );
  }
}
