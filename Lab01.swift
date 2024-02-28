import Foundation

// Strings and Text
print("Strings and Text")
// ex 1.1
print("\r \n")
print("ex 1.1")
print("\r \n")

var a = 5
var b = 10
print("\(a) + \(b) = \(a+b)")


// ex. 1.2
print("\r \n")
print("ex 1.2")
print("\r \n")

let name = "Gdansk University of Technology"
var fixedName = ""
for i in name{
  if(i == "n"){
    fixedName.append("⭐️")
  }
  else{
    fixedName.append(i)
  }
}

print(fixedName)

// ex 1.3
print("\r \n")
print("ex 1.3")
print("\r \n")

let myName = "Piotr Sulewski"
let reversedName = String(myName.reversed())
print(myName + " -> " + reversedName)

print("\r \n")


// Control Flow
print("\r \n")
print("Control Flow")
print("\r \n")
// ex 2.1
print("\r \n")
print("ex 2.1")
print("\r \n")

for _ in(1...11){
  print("I will pass this course with best mark, because Swift is great!")
}

print("\r \n")

// ex 2.2
print("\r \n")
print("ex 2.2")
print("\r \n")

let n = 6 
for i in(1...n){
  print(i*i)
}

print("\r \n")
// ex 2.3
print("\r \n")
print("ex 2.3")
print("\r \n")
let N = 4
for _ in 1...N {
  for _ in 1...N{
    print("@", terminator:"")
  }
  print()
}

print("\r \n")

// Arrays
print("\r \n")
print("Arrays")
print("\r \n")
// ex 3.1
print("\r \n")
print("ex 3.1")
print("\r \n")

var numbers = [5, 10, 20, 15, 80, 13]
print((numbers.max())!)
print("\r \n")

// ex 3.2
print("\r \n")
print("ex 3.2")
print("\r \n")
print(Array(numbers.reversed()))

print("\r \n")

// ex 3.3
print("\r \n")
print("ex 3.3")
print("\r \n")

var allNumbers = [10, 20, 10, 11, 13, 20, 10, 30]
var unique = Array<Int>()

for i in allNumbers {
  if(!unique.contains(i)){
    unique.append(i)
  }
}
print(unique)
print("\r \n")


// Sets
print("\r \n")
print("Sets")
print("\r \n")
// ex 4.1
print("\r \n")
print("ex 4.1")
print("\r \n")

var number = 10
var divisors = Set<Int>()

for i in 1...10{
  if number % i == 0{
    divisors.insert(i)
  }
}

print(divisors.sorted())


// Dictionaries
print("\r \n")
print("Dictionaries")
print("\r \n")

// ex 5.1
print("\r \n")
print("ex 5.1")
print("\r \n")

var flights: [[String: String]] = [
    [
        "flightNumber" : "AA8025",
        "destination" : "Copenhagen"
    ],
    [
        "flightNumber" : "BA1442",
        "destination" : "New York"
    ],
    [
        "flightNumber" : "BD6741",
        "destination" : "Barcelona"
    ]
]

var flightNumbers = Array<String>()

for numbers in flights {
  flightNumbers.append(numbers["flightNumber"]!)
}
print(flightNumbers)

// ex 5.2
print("\r \n")
print("ex 5.2")
print("\r \n")

var names = ["Hommer","Lisa","Bart"]
var fullNames = [[String:String]]()

for name in names {
  var fullName = [String:String]()
  fullName["lastName"] = "Simpson"
  fullName["firstName"] = name
  fullNames.append(fullName)
}

print(fullNames)

