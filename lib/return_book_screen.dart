import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'library_provider.dart';

class ReturnBookScreen extends StatelessWidget {
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController memberIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: isbnController,
              decoration: InputDecoration(labelText: 'ISBN'),
            ),
            TextField(
              controller: memberIdController,
              decoration: InputDecoration(labelText: 'Member ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final isbn = isbnController.text;
                final memberId = memberIdController.text;

                if (isbn.isNotEmpty && memberId.isNotEmpty) {
                  Provider.of<LibraryProvider>(context, listen: false).returnBook(isbn, memberId);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Return Book'),
            ),
          ],
        ),
      ),
    );
  }
}

