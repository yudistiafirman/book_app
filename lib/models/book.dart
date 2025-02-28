class Author {
  final String name;
  final int? birthYear;
  final int? deathYear;

  Author({required this.name, this.birthYear, this.deathYear});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] ?? 'Unknown Author',
      birthYear: json['birth_year'],
      deathYear: json['death_year'],
    );
  }
}

class Book {
  final int id;
  final String title;
  final List<Author> authors;
  final List<String> summaries;
  final List<String> subjects;
  final List<String> languages;
  final Map<String, String> formats;
  final int downloadCount;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.summaries,
    required this.subjects,
    required this.languages,
    required this.formats,
    required this.downloadCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Untitled',
      authors:
          (json['authors'] as List<dynamic>?)
              ?.map((a) => Author.fromJson(a))
              .toList() ??
          [],
      summaries: List<String>.from(json['summaries'] ?? []),
      subjects: List<String>.from(json['subjects'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      formats: Map<String, String>.from(json['formats'] ?? {}),
      downloadCount: json['download_count'] ?? 0,
    );
  }
}

class BookList {
  final int count;
  final String? next;
  final String? previous;
  final List<Book> results;

  BookList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BookList.fromJson(Map<String, dynamic> json) {
    return BookList(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List<dynamic>?)
              ?.map((b) => Book.fromJson(b))
              .toList() ??
          [],
    );
  }
}
