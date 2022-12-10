import XCTest
@testable import Advent2022

final class Advent2022Tests: XCTestCase {
    func testDay1() throws {
        let day1Text = try getTestData("day1")
        let elves = day1Text.split(separator: "\n", omittingEmptySubsequences: false).split(separator: "").map { Elf(foods: Array($0).compactMap { Int($0) }) }
        let sortedElves = elves.sorted { $0.totalCalories > $1.totalCalories }

        // Part 1
        let maxElf = sortedElves.first
        XCTAssertEqual(maxElf?.totalCalories, 68775)

        // Part 2
        let topThreeElves = sortedElves[..<3]
        let topThreeCalories = topThreeElves.map({ $0.totalCalories }).reduce(0, +)
        XCTAssertEqual(topThreeCalories, 202585)
    }

    func testDay2() throws {
        let day2Text = try getTestData("day2")
        let lines = day2Text.split(separator: "\n").map { String($0) }

        // Part 1
        let games = lines.compactMap { RoshamboGame(guessedGuide: $0) }
        let totalScore = games.map({ $0.score }).reduce(0, +)
        XCTAssertEqual(totalScore, 13924)

        // Part 2
        let alternateGames = lines.compactMap { RoshamboGame(actualGuide: $0) }
        // alternateGames[..<5].forEach {
        //     print("game: \($0), outcome: \($0.outcome), score: \($0.score)")
        // }
        let revisedScore = alternateGames.map({ $0.score }).reduce(0, +)
        XCTAssertEqual(revisedScore, 13448)
    }

    func testDay3() throws {
        let day2Text = try getTestData("day3")
        let rucksacks = day2Text.split(separator: "\n").compactMap { Rucksack(String($0)) }

        // Part 1
        // rucksacks[..<5].forEach {
        //     guard let common = $0.commonItemType else {
        //         return
        //     }
        //     print("rucksack: \($0), common: \(String(common)), priority \(common.priority!)")
        // }
        let totalPriority = rucksacks.compactMap({ $0.commonItemType?.priority }).reduce(0, +)
        XCTAssertEqual(totalPriority, 8109)

        // Part 2
        let groups = rucksacks.chunked(into: 3)
        let totalGroupPriority = groups.compactMap({ Character($0.badge).priority }).reduce(0, +)
        XCTAssertEqual(totalGroupPriority, 2738)
    }

    private func getTestData(_ name: String) throws -> String {
        let textUrl = Bundle.module.url(forResource: name, withExtension: "txt")
        return try String(contentsOf: textUrl!)
    }
}

// From https://www.hackingwithswift.com/example-code/language/how-to-split-an-array-into-chunks
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
