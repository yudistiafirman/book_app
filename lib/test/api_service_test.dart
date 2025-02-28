import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:book_app/models/book.dart';
import 'package:book_app/services/api_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('ApiService Tests', () {
    late ApiService apiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiService = ApiService();
    });

    test(
      'fetchBooks returns BookList if HTTP call completes successfully',
      () async {
        // Mock response sukses
        when(
          mockClient.get(
            Uri.parse('https://gutendex.com/books?mime_type=text/html&page=1'),
          ),
        ).thenAnswer(
          (_) async => http.Response('''
            {
              "count": 74808,
              "next": "https://gutendex.com/books/?mime_type=text%2Fhtml&page=2",
              "previous": null,
              "results": [
                {
                  "id": 26184,
                  "title": "Simple Sabotage Field Manual",
                  "authors": [{"name": "United States. Office of Strategic Services"}],
                  "download_count": 300524
                }
              ]
            }
          ''', 200),
        );

        final result = await apiService.fetchBooks(page: 1);

        expect(result.results.length, 1);
        expect(result.results[0].title, 'Simple Sabotage Field Manual');
        expect(result.results[0].downloadCount, 300524);
      },
    );

    test('fetchBooks throws Exception on non-200 status', () async {
      when(
        mockClient.get(
          Uri.parse('https://gutendex.com/books?mime_type=text/html&page=1'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 404));

      expect(() => apiService.fetchBooks(page: 1), throwsException);
    });

    // Test untuk searchBooks
    test(
      'searchBooks returns BookList if HTTP call completes successfully',
      () async {
        when(
          mockClient.get(
            Uri.parse(
              'https://gutendex.com/books?search=test&mime_type=text/html&page=1',
            ),
          ),
        ).thenAnswer(
          (_) async => http.Response('''
            {
              "count": 10,
              "next": null,
              "previous": null,
              "results": [
                {
                  "id": 26184,
                  "title": "Simple Sabotage Field Manual",
                  "authors": [{"name": "United States. Office of Strategic Services"}],
                  "download_count": 300524
                }
              ]
            }
          ''', HttpStatus.ok),
        );

        final result = await apiService.searchBooks('test', page: 1);

        expect(result.results.length, 1);
        expect(result.results[0].title, 'Simple Sabotage Field Manual');
        expect(result.results[0].downloadCount, 300524);
      },
    );

    test('searchBooks throws Exception on non-200 status', () async {
      when(
        mockClient.get(
          Uri.parse(
            'https://gutendex.com/books?search=test&mime_type=text/html&page=1',
          ),
        ),
      ).thenAnswer((_) async => http.Response('Error', HttpStatus.badRequest));

      expect(() => apiService.searchBooks('test', page: 1), throwsException);
    });

    // Test untuk fetchBookDetail
    test(
      'fetchBookDetail returns Book if HTTP call completes successfully',
      () async {
        when(
          mockClient.get(Uri.parse('https://gutendex.com/books/26184')),
        ).thenAnswer(
          (_) async => http.Response('''
            {
              "id": 26184,
              "title": "Simple Sabotage Field Manual",
              "authors": [{"name": "United States. Office of Strategic Services"}],
              "download_count": 300524
            }
          ''', 200),
        );

        final result = await apiService.fetchBookDetail(26184);

        expect(result.title, 'Simple Sabotage Field Manual');
        expect(result.downloadCount, 300524);
      },
    );

    test('fetchBookDetail throws Exception on non-200 status', () async {
      when(
        mockClient.get(Uri.parse('https://gutendex.com/books/26184')),
      ).thenAnswer((_) async => http.Response('Error', 404));

      expect(() => apiService.fetchBookDetail(26184), throwsException);
    });
  });
}
