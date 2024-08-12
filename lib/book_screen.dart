// lib/book_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'library_provider.dart';
import 'models.dart';

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _isbnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _isbnController,
              decoration: InputDecoration(labelText: 'ISBN'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final book = Book(
                title: _titleController.text,
                author: _authorController.text,
                isbn: _isbnController.text,
              );
              Provider.of<LibraryProvider>(context, listen: false).addBook(book);
            },
            child: Text('Add Book'),
          ),
          Expanded(
            child: Consumer<LibraryProvider>(
              builder: (context, library, child) {
                return ListView.builder(
                  itemCount: library.books.length,
                  itemBuilder: (context, index) {
                    final book = library.books[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text('by ${book.author} - ISBN: ${book.isbn}'),
                      trailing: book.isAvailable ? Text('Available') : Text('Borrowed'),
                    );
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
