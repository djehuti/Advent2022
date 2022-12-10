import Foundation

struct Elf {
    var foods: [Int]

    var totalCalories: Int { foods.reduce(0, +) }
}
