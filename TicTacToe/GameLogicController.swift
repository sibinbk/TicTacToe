//
//  GameLogicController.swift
//  TicTacToe
//
//  Created by Sibin Baby on 25/07/2016.
//  Copyright © 2016 SibinBaby. All rights reserved.
//

import UIKit

class GameLogicController: NSObject {
    enum Player: Int {
        case Player1 = 0
        case Player2 = 1
    }
    
    enum GameResult: Int {
        case NotFinished = 0
        case Player1Won
        case Player2Won
        case Tie
    }
    
    var boardSize: Int = 0 {
        didSet {
          reInitialize()
        }
    }
    
    var gameArray = [[GameCellItem]]()
    var takenCellCount = 0
    var currentPlayer = Player.Player1
     
    func reInitialize() {
        loadGameCellArray()
        // Reset current player
        currentPlayer = .Player1
        takenCellCount = 0
    }
    
    private func loadGameCellArray() {
        // Empty all cells
        for row in 0..<boardSize {
            var rowArray = [GameCellItem]()
            for column in 0..<boardSize {
                let gameCellItem = GameCellItem (title: "", isTaken: false)
                rowArray.insert(gameCellItem, atIndex: column)
            }
            gameArray.insert(rowArray, atIndex: row)
        }
    }
    
    func updateIfEmptyCellAtIndexPath(indexPath: NSIndexPath) -> Bool? {
        let gameCellItem = gameArray[indexPath.section][indexPath.row]
        
        // check if already selected
        if gameCellItem.isTaken {
            return nil
        }
        
        // Mark cell with corresponding indicator.
        gameCellItem.title = currentPlayer == .Player1 ? "X" : "O"
        gameCellItem.isTaken = true
        gameArray[indexPath.section][indexPath.row] = gameCellItem
        
        return true
    }
    
    func cellTitleForIndexPath(indexPath: NSIndexPath) -> String {
        let gameCellItem = gameArray[indexPath.section][indexPath.row]
        return gameCellItem.title
    }

    //MARK: - Check Player won.
    
    func checkForWinForIndexPath(indexPath: NSIndexPath) -> GameResult {
        // Increment taken cell count.
        takenCellCount += 1
        
        // Check if all the cells are filled.
        if takenCellCount >= (boardSize * boardSize) {
            return .Tie
        }

        let rowCheckWon = checkWinForRow(indexPath.section)
        let columnCheckWon = checkWinForColumn(indexPath.row)
        let leftDiagonalWon = checkWinForLeftDiagonal()
        let rightDiagonalWon = checkWinForRightDiagonal()
        
        if rowCheckWon || columnCheckWon || leftDiagonalWon || rightDiagonalWon {
            return currentPlayer == .Player1 ? .Player1Won : .Player2Won
        }
        
        // Switch players' turn if not finished.
        switchPlayerTurn()
        
        return .NotFinished
    }
    
    // Check row of latest move.
    private func checkWinForRow(row: Int) -> Bool {
        for column in 0..<boardSize-1 {
            let firstItem = gameArray[row][column]
            let secondItem = gameArray[row][column+1]
            if firstItem.title == "" || firstItem.title != secondItem.title {
                return false
            }
        }
        return true
    }
    
    // Check column of latest move.
    private func checkWinForColumn(column: Int) -> Bool {
        for row in 0..<boardSize-1 {
            let firstItem = gameArray[row][column]
            let secondItem = gameArray[row+1][column]
            if firstItem.title == "" || firstItem.title != secondItem.title {
                return false
            }
        }
        return true
    }
    
    // Check left-top to bottom-right diagonal.
    private func checkWinForLeftDiagonal() -> Bool {
        for i in 0..<boardSize-1 {
            let firstItem = gameArray[i][i]
            let secondItem = gameArray[i+1][i+1]
            if firstItem.title == "" || firstItem.title != secondItem.title {
                return false
            }
        }
        return true
    }
    
    // Check left-bottom to right-top diagonal.
    private func checkWinForRightDiagonal() -> Bool {
        for i in 0..<boardSize-1 {
            let firstItem = gameArray[boardSize-1-i][i]
            let secondItem = gameArray[boardSize-2-i][i+1]
            if firstItem.title == "" || firstItem.title != secondItem.title {
                return false
            }
        }
        return true
    }
    
    //MARK: - Switch player's turn.
    
    private func switchPlayerTurn() {
        currentPlayer = currentPlayer == .Player1 ? .Player2 : .Player1
    }
    
    //MARK: - Return next player's turn.
    
    func nextPlayer() -> Player {
        return currentPlayer
    }
}
