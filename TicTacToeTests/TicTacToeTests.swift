//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Sibin Baby on 26/07/2016.
//  Copyright © 2016 SibinBaby. All rights reserved.
//

import XCTest
@testable import TicTacToe

class TicTacToeTests: XCTestCase {
    
    let gameLogic = GameLogicController()
    
    override func setUp() {
        super.setUp()
    }
    
    func testNextPlayer() {
        gameLogic.currentPlayer = .Player2
        let nextPlayer = gameLogic.nextPlayer()
        XCTAssert(nextPlayer == .Player2)
    }
    
    func testSwitchPlayer() {
        gameLogic.currentPlayer = .Player1
        gameLogic.switchPlayerTurn()
        XCTAssert(gameLogic.currentPlayer == .Player2)
    }
    
    func testRowWinCheckSuccess() {
        gameLogic.boardSize = 3
        let gameItemX = GameCellItem (title: "X", isTaken: true)
        let gameItemO = GameCellItem (title: "O", isTaken: true)
        
        gameLogic.gameArray[0][0] = gameItemX
        gameLogic.gameArray[0][1] = gameItemX
        gameLogic.gameArray[0][2] = gameItemX
        
        gameLogic.gameArray[1][0] = gameItemO
        gameLogic.gameArray[1][1] = gameItemO
        gameLogic.gameArray[1][2] = gameItemO
        
        gameLogic.gameArray[2][0] = gameItemX
        gameLogic.gameArray[2][2] = gameItemO
        
        let row0result = gameLogic.checkWinForRow(0) // Success -> true [X X X]
        let row1result = gameLogic.checkWinForRow(1) // Success -> true  [O O O]
        let row2result = gameLogic.checkWinForRow(2) // Fail -> false    [X - O]
        
        XCTAssertTrue(row0result)
        XCTAssertTrue(row1result)
        XCTAssertFalse(row2result)
    }
    
    func testColumnCheckSuccess() {
        gameLogic.boardSize = 4
        let gameItemX = GameCellItem (title: "X", isTaken: true)
        let gameItemO = GameCellItem (title: "O", isTaken: true)
        
        gameLogic.gameArray[0][3] = gameItemO
        gameLogic.gameArray[1][3] = gameItemO
        gameLogic.gameArray[2][3] = gameItemO
        gameLogic.gameArray[3][3] = gameItemO
        
        gameLogic.gameArray[0][1] = gameItemO
        gameLogic.gameArray[1][1] = gameItemX
        gameLogic.gameArray[2][1] = gameItemO
        gameLogic.gameArray[3][1] = gameItemX
        
        gameLogic.gameArray[2][2] = gameItemX

        let column0result = gameLogic.checkWinForColumn(0) // Fail -> false [- - - -]
        let column1result = gameLogic.checkWinForColumn(1) // Fail -> false  [O X O X]
        let column2result = gameLogic.checkWinForColumn(2) // Fail -> false   [- - X -]
        let column3result = gameLogic.checkWinForColumn(3) // Success ->  true [O O O O]
        
        XCTAssertFalse(column0result)
        XCTAssertFalse(column1result)
        XCTAssertFalse(column2result)
        XCTAssertTrue(column3result)
    }
    
    func testDiagonalCheckSuccess() {
        gameLogic.boardSize = 3
        let gameItemX = GameCellItem (title: "X", isTaken: true)
        let gameItemO = GameCellItem (title: "O", isTaken: true)
        
        gameLogic.gameArray[0][0] = gameItemO
        gameLogic.gameArray[1][1] = gameItemO
        gameLogic.gameArray[2][2] = gameItemO
        
        gameLogic.gameArray[0][2] = gameItemX
        gameLogic.gameArray[2][0] = gameItemX
        
        let diagonalResult1 = gameLogic.checkWinForLeftDiagonal() // Success -> true [O O O]
        let diagonalResult2 = gameLogic.checkWinForRightDiagonal() // Fail -> false  [X O X]
        
        XCTAssertTrue(diagonalResult1)
        XCTAssertFalse(diagonalResult2)
    }

    func testCellUpdate() {
        gameLogic.boardSize = 6
        gameLogic.gameArray[2][5] = GameCellItem (title: "O", isTaken: true)

        let cellUpdatedSucces1 = gameLogic.updateIfEmptyCellAtIndexPath(NSIndexPath(forRow: 5, inSection: 2)) // Trying to update cell which is already taken. Returns nil
        let cellUpdatedSucces2 = gameLogic.updateIfEmptyCellAtIndexPath(NSIndexPath(forRow: 5, inSection: 1)) // Trying to update cell which is empty. Update success and returns 'true'
        
        XCTAssertNil(cellUpdatedSucces1)
        XCTAssertTrue(cellUpdatedSucces2!)
    }
    
    override func tearDown() {

        super.tearDown()
    }    
}
