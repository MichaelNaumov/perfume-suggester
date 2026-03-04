import Foundation

struct Perfume: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var seasons: [String]
    var dayTimes: [String]
    var brand: String
}
