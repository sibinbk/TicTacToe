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
    
    func loadGameCellArray() {
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
    
    func checkForWinForIndexPath(indexPath: NSIndexPath) -> GameResult {
        let row = indexPath.section
        let column = indexPath.row
        
        var rowCheckWon = true
        var columnCheckWon = true
        var leftDiagonalWon = true
        var rightDiagonalWon = true
        
        for column in 0..<boardSize-1 {
            let firstItem = gameArray[row][column]
            let secondItem = gameArray[row][column+1]
            if firstItem.title == "" || firstItem.title != secondItem.title {
                rowCheckWon = false
                break
            }
        }
        
        for row in 0..<boardSize-1 {
            let firstItem = gameArray[row][column]
            let secondItem = gameArray[row+1][column]
            if firstItem.title == "" || firstItem.title != secondItem.title {
                columnCheckWon = false
                break
            }
        }
        
        for i in 0..<boardSize-1 {
            let firstItem = gameArray[i][i]
            let secondItem = gameArray[i+1][i+1]
            if firstItem.title == "" || firstItem.title != secondItem.title {
                leftDiagonalWon = false
                break
            }
        }
        
        for i in 0..<boardSize-1 {
            let firstItem = gameArray[boardSize-1-i][i]
            let secondItem = gameArray[boardSize-2-i][i+1]
            if firstItem.title == "" || firstItem.title != secondItem.title {
                rightDiagonalWon = false
                break
            }
        }
        
        // Increment taken cell count.
        takenCellCount += 1
        
        if rowCheckWon || columnCheckWon || leftDiagonalWon || rightDiagonalWon {
            if currentPlayer == .Player1 {
                print("Player 1 Won")
                return .Player1Won
            } else {
                print("Player 1 Won")
                return .Player2Won
            }
        } else if takenCellCount == (boardSize * boardSize) {
            print("Its a Tie")
            
            return .Tie
        }
        
        // Switch players' turn if not finished.
        switchPlayerTurn()
        
        return .NotFinished
    }
    
    func switchPlayerTurn() {
        currentPlayer = currentPlayer == .Player1 ? .Player2 : .Player1
    }

}
