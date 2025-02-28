import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:book_app/providers/book_detail_provider.dart';

class BookDetailScreen extends StatelessWidget {
  final int bookId;

  const BookDetailScreen({required this.bookId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Buku')),
      body: Consumer<BookDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final book = provider.bookDetails[bookId];
          if (book == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.fetchBookDetail(bookId);
            });
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: book.formats['image/jpeg'] ?? '',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.fitHeight,
                    placeholder:
                        (context, url) =>
                            Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.book,
                            size: 80,
                            color: Colors.grey[600],
                          ),
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.authors.map((a) => a.name).join(', '),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Total Unduhan: ${book.downloadCount}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ringkasan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.summaries.isNotEmpty
                        ? book.summaries.first
                        : 'Tidak ada ringkasan',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
