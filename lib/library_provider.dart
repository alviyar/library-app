import 'package:flutter/material.dart';
import 'models.dart';

class LibraryProvider with ChangeNotifier{
  List<Book> _books=[];
  List<Member> _members=[];

  List<Book> get books => _books;
  List<Member> get members => _members;

  void addBook(Book book){
    _books.add(book);
    notifyListeners();
  }

  void addMember(Member member){
    _members.add(member);
    notifyListeners();
  }

  //lendBook method
  void lendBook(String isbn, String memberId){
    Book? book= _books.firstWhere((book)=> isbn == isbn, orElse: ()=> null as Book);
    Member? member =_members.firstWhere((member)=> member.memberId == memberId, orElse: ()=> null as Member);

  if(book!=null && book.isAvailable && member!=null){
    book.isAvailable = false;
    member.borrowedBooks?.add(book);
    notifyListeners();
    }
  }

  void returnBook(String isbn, String memberId){
    Book? book=_books.firstWhere((book)=> isbn== isbn, orElse: ()=> null as Book);
    Member? member= _members.firstWhere((member)=> member.memberId==memberId, orElse: ()=> null as Member);

  if(book!=null && book.isAvailable && member!=null){
    book.isAvailable = true;
    member.borrowedBooks?.removeWhere((borrowedBook)=> borrowedBook.isbn==isbn);
    notifyListeners();
    }
  }
}