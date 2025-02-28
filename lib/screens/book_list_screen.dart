import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_app/providers/book_provider.dart';
import 'package:book_app/screens/search_screen.dart';
import 'package:book_app/widgets/book_list_item.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider.fetchBooks();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bookProvider.fetchBooks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Buku'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          if (bookProvider.books.isEmpty && bookProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (bookProvider.books.isEmpty) {
            return Center(child: Text('Tidak ada buku yang ditemukan'));
          }
          return RefreshIndicator(
            onRefresh: bookProvider.refreshBooks,
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  bookProvider.books.length + (bookProvider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < bookProvider.books.length) {
                  final book = bookProvider.books[index];
                  return BookListItem(book: book);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
