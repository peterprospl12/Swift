import Foundation


struct Reactions: Codable {
    var likes: Int
    var hearth: Int
    var haha: Int
    var wow: Int
    var sorry: Int
    var angry: Int
    
    init(_ likes: Int = 0, _ hearth: Int = 0, _ haha: Int = 0, _ wow: Int = 0, _ sorry: Int = 0, _ angry: Int = 0) {
        self.likes = likes
        self.hearth = hearth
        self.haha = haha
        self.wow = wow
        self.sorry = sorry
        self.angry = angry
    }
}

struct JSONPost: Codable {
    var author: String
    var postInteractions: Numbers
    var creationDate: Date
    var mediaType: MediaType
}



struct Numbers: Codable {
    var reactions: Reactions
    var reactionsSum: Int
    var comments: Int
    var shares: Int
    var views: Int
    
    init(reactions: Reactions = Reactions(), comments: Int = 0, shares: Int = 0, views: Int = 0) {
        self.reactions = reactions
        self.comments = comments
        self.shares = shares
        self.views = views
        
        self.reactionsSum = reactions.likes + reactions.hearth + reactions.haha + reactions.wow + reactions.sorry + reactions.angry
    }

}

enum MediaType: String, Codable {
    case Video
    case Photo
    case Live
    case Post
}

class Post: Codable {
    var author: String
    var creationDate: Date 
    var postInteractions: Numbers
    var mediaType: MediaType

    init(_ author: String, _ creationDate: Date, _ postInteractions: Numbers, _ mediaType: MediaType) {
        self.author = author
        self.creationDate = creationDate
        self.postInteractions = postInteractions
        self.mediaType = mediaType
    }

    func printInteractions() {
        print("Author: \(self.author)")
        print("MediaType: \(self.mediaType)")
        print("CreationDate: \(formattedDate(self.creationDate))")
        print("Interactions:")
        print("Reactions: \(formattedValue(self.postInteractions.reactionsSum))")
        printReactions()
        print("Comments: \(formattedValue(self.postInteractions.comments))")
        print("Shares: \(formattedValue(self.postInteractions.shares))")
        print("Views: \(formattedValue(self.postInteractions.views))")
    }
    
    private func printReactions() {
        print("Likes: \(formattedValue(self.postInteractions.reactions.likes))")
        print("Hearth: \(formattedValue(self.postInteractions.reactions.hearth))")
        print("Haha: \(formattedValue(self.postInteractions.reactions.haha))")
        print("Wow: \(formattedValue(self.postInteractions.reactions.wow))")
        print("Sorry: \(formattedValue(self.postInteractions.reactions.sorry))")
        print("Angry: \(formattedValue(self.postInteractions.reactions.angry))")
    }

    private func formattedValue(_ value: Int) -> String {
        if value >= 1000000 {
            let kValue = value / 1000000
            return String(format: "%dM", kValue)
        }
        else if value >= 1000 {
            let kValue = value / 1000
            return String(format: "%dk", kValue)
        } else {
            return "\(value)"
        }
    }
    
    private func formattedDate(_ value: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: value)
    }

}

func parseJSONToPost(_ jsonData: Data) -> Post? {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    do {
        let decodedPost = try decoder.decode(JSONPost.self, from: jsonData)
        let post = Post(decodedPost.author, decodedPost.creationDate, decodedPost.postInteractions, decodedPost.mediaType)
        return post
    } catch {
        print("Error decoding JSON to Post: \(error)")
        return nil
    }
}

func postToJSON(_ post: Post) -> Data? {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    
    do {
        let jsonData = try encoder.encode(post)
        return jsonData
    } catch {
        print("Error encoding post to JSON: \(error)")
        return nil
    }
}

func printJSON(_ post: Post) {
    if let jsonData = postToJSON(post),
       let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    } else {
        print("Failed to convert post to JSON.")
    }
}


let creationDate = Date()
let reactions = Reactions(1000000, 5000, 100, 2000, 90000000, 10)
let postInteractions = Numbers(reactions: reactions, comments: 2000, shares: 3000, views: 1500000)

let feed = Post("Piotr Sulewski", creationDate, postInteractions, .Post)

feed.printInteractions()


print("JSON:")
printJSON(feed)

print("Enter JSON:")
if let jsonString = readLine(), let jsonData = jsonString.data(using: .utf8) {
    if let parsedPost = parseJSONToPost(jsonData) {
        print("Parsed Post:")
        parsedPost.printInteractions()
    } else {
        print("Failed to parse JSON to Post.")
    }
} else {
    print("Failed to read JSON from input.")
}


