
enum Categories: String {
    case Cities
    case Movies
    case Sport
    case Books
}

enum Levels: String {
    case Easy
    case Medium
    case Hard
}

class GameManager {
    var type: Categories
    var tries: Int
    var level: Levels
    
    init(){
        self.type = .Cities
        self.level = .Easy
        self.tries = 0
    }
    
    func getWord() -> (String, String) {
        var words: [String]
        var filled_letters: Int
        
        switch type {
            case .Cities:
                switch level {
                    case .Easy:
                        words = ["Tokio", "Paris", "Londyn"]
                    
                    case .Medium:
                        words = ["New York", "Hongkong", "Budapest"]
                    
                    case .Hard:
                        words = ["Rio De Janeiro", "Los Angeles", "San Francisco"]
                }
            
            case .Movies:
                switch level {
                    case .Easy:
                        words = ["Joker", "Diuna", "Titanic"]
                    
                    case .Medium:
                        words = ["Oppenheimer", "Interstellar", "Spiderman"]
                    
                    case .Hard:
                        words = ["Forrest Gump", "The Godfather", "Alice in Wonderland"]
                }
            
            case .Sport:
                switch level {
                    case .Easy:
                        words = ["Golf", "Tennis", "Hockey"]
                    
                    case .Medium:
                        words = ["Basketball", "Running", "Archery"]
                    
                    case .Hard:
                        words = ["Horse racing", "Table tennis", "Weighlifting"]
                }
            
            case .Books:
                switch level {
                    case .Easy:
                        words = ["1984", "Witcher", "Hobbit"]
                    
                    case .Medium:
                        words = ["Harry Potter", "Romeo and Juliet", "Fight Club"]
                    
                    case .Hard:
                        words = ["The Lord of the Rings", "The Hunger Games", "The Wizard of Oz"]
                }
        }
        switch level {
            case .Easy:
                filled_letters = 2
            case .Medium:
                filled_letters = 3
            case .Hard:
                filled_letters = 4
        }
        let randomIndex = Int.random(in: 0..<words.count)
        
        let full_word = words[randomIndex]
        var user_word = ""
        for character in full_word {
            if character == " " {
                user_word.append(" ")
            } else {
                user_word.append("_")
            }
        }
        
        var indicesToFill: [Int] = []
        while filled_letters > 0 {
            let random = Int.random(in: 0..<full_word.count)
            let randomIndex = full_word.index(full_word.startIndex, offsetBy: random)
            if full_word[randomIndex] != " " && !indicesToFill.contains(random) {
                indicesToFill.append(random)
                filled_letters -= 1
            }
        }
        
        for index in indicesToFill {
            let getIndex = full_word.index(full_word.startIndex, offsetBy: index)
            let letter = full_word[getIndex]
            user_word = String(user_word.prefix(index)) + String(letter) + String(user_word.suffix(user_word.count - index - 1))
        }
        
        return (full_word, user_word)
    }
    
    func changeGameLevel() {
        print("Choose game level:")
        print("1. Easy")
        print("2. Medium")
        print("3. Hard")
        
        if let choice = readLine(), let levelChoice = Int(choice) {
            switch levelChoice {
                case 1:
                    level = .Easy
                    tries = 3
                    print("You've selected Easy level.")
                case 2:
                    level = .Medium
                    tries = 4
                    print("You've selected Medium level.")
                case 3:
                    level = .Hard
                    tries = 5
                    print("You've selected Hard level.")
                default:
                    print("Invalid choice. Please select a number from 1 to 3.")
            }
        } 
        else {
            print("Invalid input. Please enter a number.")
        }
    }
    
    func chooseCategory() {
        print("Choose game category:")
        print("1. Cities")
        print("2. Movies")
        print("3. Sport")
        print("4. Books")
        
        if let choice = readLine(), let categoryChoice = Int(choice) {
            switch categoryChoice {
                case 1:
                    type = .Cities
                    print("You've selected Cities category.")
                case 2:
                    type = .Movies
                    print("You've selected Movies category.")
                case 3:
                    type = .Sport
                    print("You've selected Sport category.")
                case 4:
                    type = .Books
                    print("You've selected Books category.")
                default:
                    print("Invalid choice. Please select a number from 1 to 4.")
            }
        } 
        else {
            print("Invalid input. Please enter a number.")
        }
    }
    
    func gameloop() {
        var choice = ""
        
        while(choice != "exit"){
            changeGameLevel()
            chooseCategory()
            print("Try to guess!")
            let fullWord: String
            var userWord: String
            
            (fullWord, userWord) = getWord()
            var position: Int = -1
            while(tries > 0){
                print(userWord)
                print("Choose position")
                if let positionInput = readLine(), let inputNumber = Int(positionInput) {
                    position = inputNumber
                }
                if position > 0 && position <= fullWord.count {
                    position -= 1
                    print("Choose letter")
                    let letter = readLine()
                    let getIndex = fullWord.index(fullWord.startIndex, offsetBy: position)
                    if(letter == String(fullWord[getIndex])) {
                        userWord.replaceSubrange(getIndex...getIndex, with: letter ?? "")
                        print("Correct")
                        if userWord == fullWord {
                            print("You guessed!")
                            print("To exit the game, type: 'exit'")
                            if let choiceInput = readLine() {
                                choice = choiceInput
                            }
                            break
                        }
                    }
                    else {
                        print("Incorrect")
                        tries -= 1
                        print("Remaining tries: \(tries)")
                    }
                    
                }
                else {
                    print("Invalid position!")
                }
                if tries == 0 {
                    print("You lost!")
                }
            }
        }
        print("Thanks for playing!")
    }
   
    
}


let gameManager = GameManager()
gameManager.gameloop()

