import 'package:flutter/material.dart';
import 'package:book_app/models/book.dart';
import 'package:book_app/services/api_service.dart';

class BookProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final List<Book> _books = [];
  int _currentPage = 1;
  bool _isLoading = false;
  String? _nextUrl;

  List<Book> get books => _books;
  bool get isLoading => _isLoading;

  Future<void> fetchBooks() async {
    if (_isLoading || (_nextUrl == null && _currentPage > 1)) return;
    _isLoading = true;
    notifyListeners();
    try {
      final bookList = await _apiService.fetchBooks(page: _currentPage);
      _books.addAll(bookList.results);
      _nextUrl = bookList.next;
      _currentPage++;
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshBooks() async {
    _books.clear();
    _currentPage = 1;
    _nextUrl = null;
    await fetchBooks();
  }
}
