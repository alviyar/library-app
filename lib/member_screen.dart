// lib/member_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'library_provider.dart';
import 'models.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final _nameController = TextEditingController();
  final _memberIdController = TextEditingController();
  final _isbnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _memberIdController,
              decoration: InputDecoration(labelText: 'Member ID'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final member = Member(
                name: _nameController.text,
                memberId: _memberIdController.text,
              );
              Provider.of<LibraryProvider>(context, listen: false).addMember(member);
            },
            child: Text('Add Member'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _isbnController,
              decoration: InputDecoration(labelText: 'ISBN for Borrow/Return'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final memberId = _memberIdController.text;
              final isbn = _isbnController.text;
              Provider.of<LibraryProvider>(context, listen: false).lendBook(isbn, memberId);
            },
            child: Text('Borrow Book'),
          ),
          ElevatedButton(
            onPressed: () {
              final memberId = _memberIdController.text;
              final isbn = _isbnController.text;
              Provider.of<LibraryProvider>(context, listen: false).returnBook(isbn, memberId);
            },
            child: Text('Return Book'),
          ),
          Expanded(
            child: Consumer<LibraryProvider>(
              builder: (context, library, child) {
                return ListView.builder(
                  itemCount: library.members.length,
                  itemBuilder: (context, index) {
                    final member = library.members[index];
                    return ListTile(
                      title: Text(member.name),
                      subtitle: Text('ID: ${member.memberId}'),
                      trailing: Text('${member.borrowedBooks.length} books borrowed'),
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
