import Foundation

struct Rucksack {
    let bothCompartments: String
    let compartmentA: String
    let compartmentB: String

    var commonItemType: Character? {
        let setA = Set<Character>(compartmentA)
        let setB = Set<Character>(compartmentB)
        let intersection = setA.intersection(setB)
        guard intersection.count == 1 else {
            return nil
        }
        return intersection.first!
    }

    init?(_ compartments: String) {
        guard compartments.count % 2 == 0 else {
            return nil
        }
        let itemCount = compartments.count / 2
        self.bothCompartments = compartments
        self.compartmentA = String(compartments.prefix(itemCount))
        self.compartmentB = String(compartments.suffix(itemCount))
    }
}

extension Character {
    var priority: Int? {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        guard let idx = letters.firstIndex(of: self) else {
            return nil
        }
        return letters.distance(from: letters.startIndex, to: idx) + 1
    }
}

extension Array where Element == Rucksack {
    var badge: String {
        guard let initial = first else {
            return ""
        }
        var remaining = Set<Character>(initial.bothCompartments)
        dropFirst().forEach {
            remaining = remaining.intersection(Set<Character>($0.bothCompartments))
        }
        return String(remaining)
    }
}
