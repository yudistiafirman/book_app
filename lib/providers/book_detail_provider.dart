import 'package:flutter/material.dart';
import 'package:book_app/models/book.dart';
import 'package:book_app/services/api_service.dart';

class BookDetailProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<int, Book> _bookDetails = {};
  bool _isDetailLoading = false;

  Map<int, Book> get bookDetails => _bookDetails;
  bool get isDetailLoading => _isDetailLoading;

  Future<void> fetchBookDetail(int id) async {
    if (_isDetailLoading || _bookDetails.containsKey(id)) return;
    _isDetailLoading = true;
    notifyListeners();
    try {
      final book = await _apiService.fetchBookDetail(id);
      _bookDetails[id] = book;
    } catch (e) {
      print('Error fetching book detail: $e');
    } finally {
      _isDetailLoading = false;
      notifyListeners();
    }
  }

  void clearBookDetail(int id) {
    _bookDetails.remove(id);
    notifyListeners();
  }
}
