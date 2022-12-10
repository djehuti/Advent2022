import Foundation

enum RoshamboOutcome: Int {
    case lose = 0
    case tie = 3
    case win = 6

    init?(_ value: String) {
        let values: [String: RoshamboOutcome] = [
            "X": .lose,
            "Y": .tie,
            "Z": .win,
        ]
        guard let v = values[value] else {
            return nil
        }
        self = v
    }
}

enum RoshamboPlay: Int {
    case rock = 1
    case paper = 2
    case scissors = 3

    func against(_ opponent: RoshamboPlay) -> RoshamboOutcome {
        switch self {
        case .rock:
            switch opponent {
            case .rock:
                return .tie
            case .paper:
                return .lose
            case .scissors:
                return .win
            }
        case .paper:
            switch opponent {
            case .rock:
                return .win
            case .paper:
                return .tie
            case .scissors:
                return .lose
            }
        case .scissors:
            switch opponent {
            case .rock:
                return .lose
            case .paper:
                return .win
            case .scissors:
                return .tie
            }
        }
    }

    func playTo(_ outcome: RoshamboOutcome) -> RoshamboPlay {
        switch self {
        case .rock:
            switch outcome {
            case .win:
                return .paper
            case .lose:
                return .scissors
            case .tie:
                return .rock
            }
        case .paper:
            switch outcome {
            case .win:
                return .scissors
            case .lose:
                return .rock
            case .tie:
                return .paper
            }
        case .scissors:
            switch outcome {
            case .win:
                return .rock
            case .lose:
                return .paper
            case .tie:
                return .scissors
            }
        }
    }

    init?(_ value: String) {
        let values: [String: RoshamboPlay] = [
            "A": .rock,
            "B": .paper,
            "C": .scissors,
            "X": .rock,
            "Y": .paper,
            "Z": .scissors
        ]
        guard let v = values[value] else {
            return nil
        }
        self = v
    }
}

struct RoshamboGame {
    let opponentMove: RoshamboPlay
    let playerMove: RoshamboPlay

    var outcome: RoshamboOutcome { playerMove.against(opponentMove) }
    var score: Int { playerMove.rawValue + outcome.rawValue }

    init?(guessedGuide value: String) {
        let moves = value.split(separator: " ").map { String($0) }
        guard moves.count == 2 else {
            return nil
        }
        guard let opp = RoshamboPlay(moves[0]), let plyr = RoshamboPlay(moves[1]) else {
            return nil
        } 
        self.opponentMove = opp
        self.playerMove = plyr
    }

    init?(actualGuide value: String) {
        let values = value.split(separator: " ").map { String($0) }
        guard values.count == 2 else {
            return nil
        }
        guard let opp = RoshamboPlay(values[0]), let outcome = RoshamboOutcome(values[1]) else {
            return nil
        }
        self.opponentMove = opp
        self.playerMove = opp.playTo(outcome)
    }
}
