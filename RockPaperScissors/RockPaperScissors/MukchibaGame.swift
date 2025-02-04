//
//  MukchibaGame.swift
//  RockPaperScissors
//
//  Created by 김동욱 on 2022/02/16.
//

final class MukchibaGame: RockPaperScissorsGame {
    
    var turn: Turn
    
    init(turn: Turn) {
        self.turn = turn
    }
    
    override func start() {
        printGameGuide()
        let userInput = inputUserNumber()
        
        switch userInput {
        case 0:
            printGameOverMessage()
        case 1, 2, 3:
            compareSigns(userInput: userInput)
        default:
            printInputErrorMessage()
            changeTurn(to: .computer)
            start()
        }
    }
    
    override func printGameGuide() {
        print("[\(turn.message) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> :", terminator: "")
    }
    
    func changeTurn(to player: Turn) {
        turn = player
    }
    
    override func makeUserSign(userInput: Int?) -> RockPaperScissors? {
        guard let userNumber = userInput else {
            return nil
        }
        
        guard var userSign = RockPaperScissors(rawValue: userNumber) else {
            return nil
        }
        
        if userSign == .rock {
            userSign = .scissors
        } else if userSign == .scissors {
            userSign = .rock
        }
    
        return userSign
    }
    
    override func printGameResult(gameResult: GameResult) {
        switch gameResult {
        case .win:
            changeTurn(to: .user)
            printCurrentTurn()
            start()
        case .lose:
            changeTurn(to: .computer)
            printCurrentTurn()
            start()
        case .draw:
            printWinner()
        }
    }
    
    func printCurrentTurn() {
        print("\(turn.message)의 턴입니다")
    }
    
    func printWinner() {
        print("\(turn.message)의 승리!")
    }
}
