

func minValue(_ val1: Int, _ val2: Int) -> Int {
    return min(val1, val2);
}


func lastDigit(_ val1: Int) -> Int {
    return val1 % 10;
}

func divides(_ a: Int, _ b: Int) -> Bool {
    
    if(a % b == 0){
        return true;
    }
    else{
        return false;
    }
}

func countDivisors(_ val1: Int) -> Int {
    var counter = 0;
    for i in 1...val1{
        if(divides(val1, i)){
            counter += 1
        }
    }
    return counter
}

func isPrime(_ val1: Int) -> Bool {
    
    if(countDivisors(val1) == 2){
        return true;
    }
    else{
        return false;
    }
}


func smartBart(_ n: Int, closure: () -> ()) {
    for _ in 1...n {
        closure()
    }
}

func minmax(_ val1: Int, _ val2: Int) -> (Int, Int){
    return (min(val1, val2), max(val1, val2))
}

print("-------------- 1.1 MinValue --------------")
print("Min of 142 | 11  is", minValue(142, 11))
print("Min of 142 | 1151  is", minValue(142, 1151))
print("Min of 3125 | 4372  is", minValue(4372, 3125))



print("-------------- 1.2 LastDIgit --------------")
print("Last digit of 141 is", lastDigit(141))
print("Last digit of 14178 is", lastDigit(14178));

print("-------------- 1.3 divides --------------")
print(divides(7, 3))
print(divides(8, 4))

print("-------------- 1.3 countDivisors --------------")
print(countDivisors(1))
print(countDivisors(10))
print(countDivisors(12))

print("-------------- 1.3 isPrime --------------")
print(isPrime(3))
print(isPrime(8))
print(isPrime(13))

print("-------------- 2.1 smartBart --------------")
var message: () -> () = {
    print("I will pass this course with the best mark, because Swift is great!")
}
smartBart(5, closure: message)



print("-------------- 2.2 filter --------------")

let numbers = [10, 16, 18, 30, 38, 40, 44, 50]

print(numbers.filter{$0 % 4 == 0})


print("------------- 2.3/4 reduce --------------")
print(numbers.reduce(0){max($0, $1)})

var strings = ["Gdansk", "University", "of", "Technology"]
print(strings.reduce(""){$0 + $1 + " "})



print("--------------2.5  Map|Filter|Reduce --------------")

let numbers1 = [1, 2 ,3 ,4, 5, 6]

print(numbers1.filter{$0 % 2 == 1}.map{$0*$0}.reduce(0){$0 + $1})




print("-------------- 3.1/2 Tuples --------------")
print(minmax(33, 20))


var stringsArray = ["gdansk", "university", "gdansk", "university", "university", "of", "technology", "technology", "gdansk", "gdansk"]

var dict = [String: Int]()

for word in stringsArray {
    if let count = dict[word] {
        dict[word] = count + 1
    } else {
        dict[word] = 1
    }
}

var countedStrings = [(String, Int)]()

for word in dict {
    countedStrings.append((word.key, word.value))
}

print(countedStrings.sorted{$0.1 > $1.1})


print("-------------- 4.1 Enum --------------")

enum Day: Int {
    case Monday = 1
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday

 func dayEmojis() -> String {
        switch self {
        case .Monday:
            return "🚕"
        case .Tuesday:
            return "🎵"
        case .Wednesday:
            return "🌈"
        case .Thursday:
            return "🍩"
        case .Friday:
            return "🎉"
        case .Saturday:
            return "🌃"
        case .Sunday:
            return "⏰"
        }
    }
}

let day = Day.Sunday
print(day.dayEmojis())






