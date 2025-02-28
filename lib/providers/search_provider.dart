import 'package:flutter/material.dart';
import 'package:book_app/models/book.dart';
import 'package:book_app/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Book> _searchResults = [];
  bool _isSearching = false;
  String _searchQuery = '';

  List<Book> get searchResults => _searchResults;
  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;

  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      _searchResults.clear();
      _searchQuery = '';
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _searchQuery = query;
    notifyListeners();
    try {
      final bookList = await _apiService.searchBooks(query);
      _searchResults = bookList.results;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Gagal mencari buku: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      _searchResults.clear();
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults.clear();
    _searchQuery = '';
    _isSearching = false;
    notifyListeners();
  }
}
