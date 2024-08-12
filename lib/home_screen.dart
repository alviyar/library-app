import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'library_provider.dart';
import 'models.dart';
import 'book_screen.dart';
import 'member_screen.dart';
import 'lend_book_screen.dart'; // Import LendBookScreen
import 'return_book_screen.dart'; // Import ReturnBookScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Library",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 158, 66),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Consumer<LibraryProvider>(
              builder: (context, libraryProvider, child) {
                return Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: libraryProvider.books.length,
                    itemBuilder: (context, index) {
                      final book = libraryProvider.books[index];
                      return ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.isbn),
                        trailing: Icon(
                          book.isAvailable ? Icons.check_circle : Icons.remove_circle,
                          color: book.isAvailable ? Colors.green : Colors.red,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showAddBookDialog(context);
                    },
                    child: Text("Add Book"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MemberScreen()),
                      );
                    },
                    child: Text("Add Member"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LendBookScreen()), // Navigate to LendBookScreen
                      );
                    },
                    child: Text("Lend Book"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReturnBookScreen()), // Navigate to ReturnBookScreen
                      );
                    },
                    child: Text("Return Book"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBookDialog(BuildContext context) {
    final isbnController = TextEditingController();
    final titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Book"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: isbnController,
              decoration: InputDecoration(labelText: "ISBN"),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final isbn = isbnController.text;
              final title = titleController.text;
              if (isbn.isNotEmpty && title.isNotEmpty) {
                final book = Book(title: title, isbn: isbn, isAvailable: true);
                Provider.of<LibraryProvider>(context, listen: false).addBook(book);
                Navigator.of(context).pop();
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}

