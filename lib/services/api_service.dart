import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:book_app/models/book.dart';

class ApiService {
  static const String baseUrl = 'https://gutendex.com/books';

  Future<BookList> fetchBooks({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?mime_type=text/html&page=$page'),
    );
    if (response.statusCode == 200) {
      return BookList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat daftar buku');
    }
  }

  Future<BookList> searchBooks(String query, {int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?search=$query&mime_type=text/html&page=$page'),
    );
    if (response.statusCode == 200) {
      return BookList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mencari buku');
    }
  }

  Future<Book> fetchBookDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat detail buku dengan ID $id');
    }
  }
}
