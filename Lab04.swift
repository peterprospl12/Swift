import Foundation

enum LocationType: String {
    case Restaurant
    case Pub
    case Museum
    case Monument
}

struct Location {
    var id: Int
    var type: LocationType
    var name: String
    var rating: Int
    
    init(_ id: Int, _ type: LocationType, _ name: String, _ rating: Int) {
        self.id = id
        self.type = type
        self.name = name
        if rating < 1 {
            self.rating = 1
        } else if rating > 5 {
            self.rating = 5
        } else {
            self.rating = rating
        }
    }
}

class City {
    var id: Int
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var keywords: [String]
    var locations: [Location]
    
    init(_ id: Int, _ name: String, _ description: String, _ latitude: Double, _ longitude: Double, _ keywords: [String], _ locations: [Location] = []){
        self.id = id
        self.name = name 
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.keywords = keywords
        self.locations = locations
    }
}

func findCitiesByName(_ cities: [City], _ name: String) -> [City] {
    var foundedCities = [City]()
    for city in cities{
        if city.name == name {
            foundedCities.append(city);
        }
    }
    return foundedCities
}

func findCitiesByKeyword(_ cities: [City], _ keyword: String) -> [City] {
    var foundedCities = [City]()
    
    for city in cities {
        for city_keyword in city.keywords{
            if(city_keyword == keyword){
                foundedCities.append(city)
                break
            }
        }
    }
    return foundedCities
}

func degreesToRadians(_ degrees: Double) -> Double {
    return degrees * .pi / 180.0
}


func calcDistance(_ city_a: City, _ city_b: City) -> Double {
    let earthRadius = 6371.0
    
    let lat1 = degreesToRadians(city_a.latitude)
    let lat2 = degreesToRadians(city_b.latitude)
    let lon1 = degreesToRadians(city_a.longitude)
    let lon2 = degreesToRadians(city_b.longitude)
    
    let dLat = lat2 - lat1
    let dLon = lon2 - lon1
    
    let a = sin(dLat/2) * sin(dLat/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2)
    let c = 2 * atan2(sqrt(a), sqrt(1-a))
    let distance = earthRadius * c
    return distance
    
}

func findClosestCity(_ user_lat: Double, _ user_lon: Double, _ cities: [City]) {
    
    var closest_city = cities[0]
    var closest_distance = Double.infinity
    var farthest_city = cities[0]
    var farthest_distance = -Double.infinity
    let temp_city = City(0,"","", user_lat, user_lon, [""])
    for city in cities {
        let distance = calcDistance(temp_city, city)
        //print("\(distance) with \(city.name)")
        if distance < closest_distance {
            closest_distance = distance
            closest_city = city
        }
        
        if distance > farthest_distance {
            farthest_distance = distance
            farthest_city = city
        }
    }
    print("Closest city is \(closest_city.name) and farthest is \(farthest_city.name)")
    //return [closest_city, farthest_city]
}


func findFarthestCities(_ cities: [City]) {
    
    var cityA = cities[0]
    var cityB = cities[0]
    var farthestDistance = -Double.infinity
    for i in 0..<cities.count {
        for j in (i+1)..<cities.count {
            let temp_distance = calcDistance(cities[i], cities[j])
            //print("\(i+1) \(j+1)| \(temp_distance) | \(cities[i].name), \(cities[j].name)")
            if temp_distance > farthestDistance {
                farthestDistance = temp_distance
                cityA = cities[i]
                cityB = cities[j]
            }
        }
    }
    
    print("Two farthest cities are: \(cityA.name) and \(cityB.name)")
    
}


func findFiveStarsRestaurants(_ cities: [City]) {
    var foundCities = [City]()
    for city in cities {
        for location in city.locations {
            if location.rating == 5 {
                foundCities.append(city)
            }
        }
    }
    print("Cities with 5-star restaurants")
    for city in foundCities {
        print(city.name)
    }
}

func printSortedLocations(_ city: City) {
    var tempLocations = city.locations
    tempLocations.sort(by: { $0.rating > $1.rating })

    for location in tempLocations {
        print("\(location.name) - Rating: \(location.rating)")
    }
}

func printFiveStarLocations(_ cities: [City]) {
    for city in cities {
        var counter = 0
        var locations = [Location]()
        for location in city.locations{
            if location.rating == 5 {
                counter += 1
                locations.append(location)
            }
        }
        if counter > 0 {
            print("\(city.name) has \(counter) 5-star locations: ")
            for tempLocation in locations{
                print(tempLocation.name)
            }
        }
        else {
            print("\(city.name) has \(counter) 5-star locations")
        }
        print()
    }
    print()
    print()
}


let cities: [City] = [
    City(1, "New York", "The city that never sleeps", 40.7128, -74.0060, ["urban", "culture", "business"]),
    City(2, "London", "Capital of the United Kingdom", 51.5074, -0.1278, ["history", "architecture", "culture"]),
    City(3, "Paris", "Capital of France", 48.8566, 2.3522, ["romance", "art", "fashion"]),
    City(4, "Tokyo", "Capital of Japan", 35.6895, 139.6917, ["technology", "pop culture", "food"]),
    City(5, "Rome", "Capital of Italy", 41.9028, 12.4964, ["history", "art", "architecture"]),
    City(6, "Sydney", "Largest city in Australia", -33.8688, 151.2093, ["beaches", "harbour", "culture"]),
    City(7, "Rio de Janeiro", "Brazil's second-largest city", -22.9068, -43.1729, ["beaches", "carnival", "samba"]),
    City(8, "Dubai", "Major business hub in the Middle East", 25.276987, 55.296249, ["modern", "luxury", "business"]),
    City(9, "Berlin", "Capital of Germany", 52.5200, 13.4050, ["history", "culture", "nightlife"]),
    City(10, "Moscow", "Capital of Russia", 55.7558, 37.6176, ["history", "architecture", "culture"]),
    City(11, "Istanbul", "Transcontinental city in Turkey", 41.0082, 28.9784, ["history", "culture", "cuisine"]),
    City(12, "Cairo", "Capital of Egypt", 30.0444, 31.2357, ["history", "culture", "ancient"]),
    City(13, "Mexico City", "Capital of Mexico", 19.4326, -99.1332, ["history", "culture", "food"]),
    City(14, "Bangkok", "Capital of Thailand", 13.7563, 100.5018, ["culture", "street food", "temples"]),
    City(15, "Buenos Aires", "Capital of Argentina", -34.6037, -58.3816, ["culture", "tango", "food"]),
    City(16, "Toronto", "Largest city in Canada", 43.65107, -79.347015, ["multicultural", "arts", "sports"]),
    City(17, "Mumbai", "Largest city in India", 19.0760, 72.8777, ["culture", "business", "food"]),
    City(18, "Seoul", "Capital of South Korea", 37.5665, 126.9780, ["technology", "culture", "pop culture"]),
    City(19, "Los Angeles", "Second-largest city in the United States", 34.0522, -118.2437, ["entertainment", "beaches", "culture"]),
    City(20, "Barcelona", "Capital of Catalonia, Spain", 41.3851, 2.1734, ["art", "architecture", "beaches"])
]

//      Search 1.1
print("Search 1.1: ")
var foundCities1 = findCitiesByName(cities, "Barcelona")
for city in foundCities1 {
    print(city.description)
}
print()

//      Search 1.2
print("Search 1.2")
let keyword = "art"
let foundCities2 = findCitiesByKeyword(cities, keyword)
for city in foundCities2 {
    print(city.name)
}
print()

// Distance 1.1
print("Distance 1.1")
var cityA = cities[1]
var cityB = cities[2]
let distance = calcDistance(cityA, cityB)
print("Distance between \(cityA.name) and \(cityB.name) is: \(distance) km.")
print()

// Distance 1.2
print("Distance 1.2")
var my_lat = 54.372158
var my_lon = 18.638306

findClosestCity(my_lat, my_lon, cities)
print()

// Distance 1.3
print("Distance 1.3")
findFarthestCities(cities)
print()

// Extend data model

var locations = [Location]()

let locationTypes: [LocationType] = [.Restaurant, .Pub, .Museum, .Monument]

for i in 1...20 {
    let randomIndex = Int.random(in: 0..<locationTypes.count)
    let randomType = locationTypes[randomIndex]
    let randomRating = Int.random(in: 1...5)
    let location = Location(i, randomType, "\(randomType.rawValue) \(i)", randomRating)
    locations.append(location)
}

for i in 0..<cities.count {
    cities[i].locations = [locations[i]]
    //print("\(locations[i].rating) | \(cities[i].name)")
}

// Advance search 1.1
print("Advance search 1.1")
findFiveStarsRestaurants(cities)
print()

// Advance search 1.2
print("Advance search 1.2")
cities[10].locations.append(Location(5, locationTypes[2], "CofCo", 3))
cities[10].locations.append(Location(6, locationTypes[1], "Jajko", 5))
cities[10].locations.append(Location(11, locationTypes[0], "Naselko", 1))


printSortedLocations(cities[10])
print()


// Advance search 1.3
print("Advance search 1.3")
printFiveStarLocations(cities)
print()



