import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_app/providers/search_provider.dart';
import 'package:book_app/widgets/book_list_item.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        Provider.of<SearchProvider>(context, listen: false).clearSearch();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      Provider.of<SearchProvider>(context, listen: false).searchBooks(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Buku')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Masukkan judul buku',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                if (searchProvider.isSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (searchProvider.searchResults.isEmpty &&
                    searchProvider.searchQuery.isNotEmpty) {
                  return const Center(child: Text('Tidak ada hasil pencarian'));
                }
                return ListView.builder(
                  itemCount: searchProvider.searchResults.length,
                  itemBuilder: (context, index) {
                    final book = searchProvider.searchResults[index];
                    return BookListItem(book: book);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
