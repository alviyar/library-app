class Book{
  String title;
  String? author;
  String isbn;
  bool isAvailable;

  Book({required this.title,this.author,required this.isbn,this.isAvailable=true});
}

class Member{
  String name;
  String memberId;
  List<Book> borrowedBooks;

  Member({required this.name,required this.memberId}) :borrowedBooks=[];

}