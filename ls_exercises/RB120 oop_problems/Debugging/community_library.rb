class Library
  attr_accessor :address, :phone, :books

  def initialize(address, phone)
    @address = address
    @phone = phone
    @books = Books.new
  end

  def check_in(book)
    books.push(book)
  end
end

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def display_data
    puts "---------------"
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "ISBN: #{isbn}"
    puts "---------------"
  end
end

class Books
  def initialize
    @all_books = []
  end

  def push(book)
    all_books.push(book)
  end

  def display_data
    all_books.each { |book| book.display_data }
  end

  private

  attr_accessor :all_books
end

community_library = Library.new('123 Main St.', '555-232-5652')
learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

community_library.check_in(learn_to_program)
community_library.check_in(little_women)
community_library.check_in(wrinkle_in_time)

community_library.books.display_data

=begin

The issue here is on line 46, `community_library.books.display_data`. There is no `display_data` method for the array object
returned by the `books` method call.

We could create a new `Books` class, whose objects are initialized with an empty array as an instance variable.
Then we create a `push` instance method in order to add new Book objecfts to this array, which is a form of
method overloading, as this method itself will call on `Array#push`.
This `Books` class will then also define a `display_data` instance method, like our custom `Books#push` method, this method will
also utilize method overloading, and will call `Book#display_data` for every Book object in all_books array.

The less cumbersome approach would be to define a Library instance method which invokes `Book#display_data` for each element in its `books` Array object.
=end