//: Playground - For map(), reduce(), filter() and flatMap()

import Cocoa

var str = "Hello, playground"

//: Old Method Logic for combining array of String

let coffees = [ "Cappuccino", "Latte", "Macchiato" ]
var commaSeparatedCoffees = ""

for coffee in coffees
{
    commaSeparatedCoffees += coffee
    if coffee != coffees.last
    {
        commaSeparatedCoffees += ", "
    }
}
commaSeparatedCoffees

let commaSeparatedCoffes = coffees.reduce("")
{
        wholeString, coffee in
        let maybeComma = (coffee == coffees.last) ? "" : ", "
        return "\(wholeString)\(coffee)\(maybeComma)"
}
commaSeparatedCoffes

/*:
  The below example we can able elimate more no of lines, which is present in the above example
*/

let commaSeparated = coffees.reduce(""){$0+$1}

commaSeparated

/*:
Append the array for any data type by using generics
*/

func join<T : Equatable>(objs: [T], separator: String) -> String {
    return objs.reduce("")
    {
        sum, obj in
        let maybeSeparator = (obj == objs.last) ? "" : separator
        return "\(sum)\(obj)\(maybeSeparator)"
    }
}

let fruits = [ "Apples", "Bananas", "Cherries" ]
let commaSeparatedFruits = join(fruits, separator: ", ")

//: Adding a sequence of number
let numbers = [Int](0..<10)
let total = numbers.reduce(0)
{
    return $0 + $1
}
//: More succinct

let number = [Int](0..<10)
let nextTotal = number.reduce(0, combine: +)

//: Calculating Avg of age of all the person

struct Person
{
    let name: String
    let age: Int
}

let people = [
    Person(name: "Katie",  age: 23),
    Person(name: "Bob",    age: 21),
    Person(name: "Rachel", age: 33),
    Person(name: "John",   age: 27),
    Person(name: "Megan",  age: 15)
]

let ages: [Int] = people.map { return $0.age }
let agesTotal   = ages.reduce(0) { return $0 + $1 }
let averageAge  = Double(agesTotal) / Double(ages.count)

ages
agesTotal
averageAge

//: Array of array example by using generics

let arrayOfArrays = [
    [ 0, 1, 2 ],
    [ 3, 4, 5 ],
    [ 6, 7, 8 ]
]

let flattened: [Int] = arrayOfArrays.reduce([])
{
    first, second in
    return first + second
}

func flatten<T>(a: [[T]]) -> [T]
{
    return a.reduce([])
    {
        res, ca in
        return res + ca
    }
}

let flattenedTwo = flatten(arrayOfArrays)

//: Find out the unique likes from list of likes

struct User
{
    let name: String
    let likes: [String]
}

let users = [
    User(name: "Julius",    likes: [ "Programming", "Snow", "Whiskey", "Cats" ]),
    User(name: "Stephanie", likes: [ "Video Games", "Horseback Riding", "Cats", "Orange Juice" ]),
    User(name: "Bill",      likes: [ "Pencils", "Summer", "Cats", "Horseback Riding" ]),
    User(name: "Melanie",   likes: [ "Watches", "Cats", "Programming", "Writing" ])
]

let uniqueLikes: NSSet = flatten(users.map({ u in u.likes })).reduce(NSSet())
{
    set, like in
    return set.setByAddingObject(like)
}

uniqueLikes

//: Playing with boolean

let booleans = [
    false,
    false,
    true,
    false,
    true,
    true
]

let allTrue = booleans.reduce(true)
{
    (sum, next) in
    return sum && next
}

let allFalse = booleans.reduce(true)
{
    (sum, next) in
    return sum && !next
}

let anyTrue = booleans.reduce(false)
{
    (sum, next) in
    return sum || next
}

let anyFalse = booleans.reduce(false)
{
    (sum, next) in
    return sum || !next
}

//: Logical Operation

struct OptionState
{
    let title: String
    let selected: Bool
}

let optionStates = [
    OptionState(title: "Objective-C", selected: true),
    OptionState(title: "Swift",       selected: true),
    OptionState(title: "Haskell",     selected: false),
    OptionState(title: "Ruby",        selected: true)
]

let allSelected = optionStates.reduce(true)
{
    return $0 && $1.selected
}

let anySelected = optionStates.map({ os in os.selected }).reduce(false)
{
    return $0 || $1
}


//: More Fun on join() reduce() and flatMap()

let nestedArray = [[1,2,3,4],[6,7,8,9]]

let flattenedThree = nestedArray.flatMap{$0}
let reduced = nestedArray.reduce([], combine: {$0 + $1})
flattenedThree
reduced

let flattenedPlus = nestedArray.flatMap{$0 + [5]}
let reducedPlus = nestedArray.reduce([], combine: {$0 + [5] + $1})

flattenedPlus
reducedPlus

["one","two","three"].reduce("",combine:{$0 + $1}) // "onetwothree"
["one","two","three"].reduce("",combine:{$1 + $0}) // "threetwoone"
["one","two","three"].reduce("",combine:{$1 + "-" + $0}) // "three-two-one-"

let strArr = ["one","two","three"]

strArr.enumerate().reduce("",combine:{$0 + $1.element + ($1.index < strArr.endIndex-1 ? "-" : "") }) // "one-two-three"

[["one","two","three"],["five","six","seven"]].reduce(["four"],combine:{$0 + $1}) // ["four", "one", "two", "three", "five", "six", "seven"]

let a = [["one","two","three"],["five","six","seven"],["eight","nine","ten"]].flatMap{$0 + ["four"]}
a // ["one", "two", "three", "four", "five", "six", "seven", "four", "eight", "nine", "ten", "four"]

let b = [["one","two","three"],["five","six","seven"],["eight","nine","ten"]].reduce([],combine:{$0 + $1 + ["four"]})
b // ["one", "two", "three", "four", "five", "six", "seven", "four", "eight", "nine", "ten", "four"]

let arr:[Int?] = [1,nil,2,nil,3]
arr.flatMap{$0} // [1,2,3]
arr.filter({$0 != nil}) // [1,2,3]
arr.reduce([Int](), combine:
{
    guard let n = $1 else { return $0 }
    return $0 + [n]
    }
) // [1,2,3]


var evens = [Int]()
for i in 1...10
{
    if i % 2 == 0
    {
        evens.append(i)
    }
}
print(evens)

//: Functional Filtering

func isEven(number: Int) -> Bool
{
    return number % 2 == 0
}
evens = Array(1...10).filter(isEven)
print(evens)

evens = Array(1...10).filter { (number) in number % 2 == 0 }
print(evens)

evens = Array(1...10).filter { $0 % 2 == 0 }
print(evens)

//: Functional Reduce

var evenSum = 0
for i in evens
{
    evenSum += i
}

print(evenSum)

evenSum = Array(1...10)
    .filter { (number) in number % 2 == 0 }
    .reduce(0) { (total, number) in total + number }

print(evenSum)

let maxNumber = Array(1...10)
    .reduce(0) { (total, number) in min(total, number) }
print(maxNumber)

//: Custom SequenceType and GeneratorType
/*:
We can write our own custom sequence by adoting SequenceType and GeneratorType Protocol. In order to do that, we need to implement generate() method in SequenceType(which is used to provide the generatortype type) and next() method in GeneratorType(which is used to provide next element). Once next() method will return nil the loop will get terminated
*/

class Book
{
    let title: String, yearPublished: Int
    init(title: String, yearPublished: Int)
    {
        self.title = title
        self.yearPublished = yearPublished
    }
}

class Library
{
    var books = [Book]()
    var numberOfBooks: Int
        {
            return self.books.count
    }
    
    init(books: [Book])
    {
        self.books = books
    }
}

let book1 = Book(title: "The Swift Programming Language", yearPublished: 2014)
let book2 = Book(title: "The Pragmatic Programmer", yearPublished: 1999)
let book3 = Book(title: "Clean Code", yearPublished: 2008)
let book4 = Book(title: "Refactoring", yearPublished: 2008)

let library = Library(books: [book1, book2, book3, book4])

extension Library : SequenceType
{
    typealias Generator = LibraryGenerator
    func generate() -> Generator
    {
        return LibraryGenerator(library: self)
    }
}


class LibraryGenerator: GeneratorType
{
    var currentIndex = 0
    let library: Library
    typealias Element = Book
    init(library: Library)
    {
        self.library = library
    }
    
    func next() -> Element?
    {
        if (currentIndex < self.library.numberOfBooks)
        {
            return self.library.books[currentIndex++]
        }
        return nil
    }
    
}

for book in library
{
    print(book.title)
}

let listOfBooks = library.map {$0.title}

listOfBooks

let booksPublishedOn2008 = library.filter {$0.yearPublished==2008}

booksPublishedOn2008.count

