import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'library_provider.dart';
import 'home_screen.dart';
import 'book_screen.dart';
import 'member_screen.dart';
import 'lend_book_screen.dart';
import 'return_book_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Library Management',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/books': (context) => BookScreen(),
          '/members': (context) => MemberScreen(),
          '/lend': (context) => LendBookScreen(),
          '/return': (context) => ReturnBookScreen(),
        },
      ),
    );
  }
}
