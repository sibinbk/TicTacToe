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
    
    enum WhoWon: Int {
        case Player1Won = 0
        case Player2Won = 1
        case Tie = 2
    }
    
    var boardSize: Int = 0 {
        didSet {
          reInitialize()
        }
    }
    
    var gameArray = [[GameCellItem]]()
    var gameHistory: GameHistory!
    var gameFininshed = false
    var takenCellCount = 0
    var currentPlayer = Player.Player1
//    var infoLabel: UILabel!
    
    func reInitialize() {
        loadGameCellArray()
        // Reset current player
        currentPlayer = .Player1
        takenCellCount = 0
        gameFininshed = false
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
    
    func checkForWinForIndexPath(indexPath: NSIndexPath) {
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
            // Hide player's turn label
//            infoLabel.hidden = true
            
            let messageInfo: String
            if currentPlayer == .Player1 {
                messageInfo = "Player 1 Won"
                //                saveGameResult(.Player1Won)
            } else {
                messageInfo = "Player 2 Won"
                //                saveGameResult(.Player2Won)
            }
            
            self.gameFininshed = true
            
            print(messageInfo)
            
            //            let alertController = UIAlertController(title: "Game Over!", message: messageInfo, preferredStyle: .Alert)
            
            //            let cancelAction = UIAlertAction(title: "Play Again", style: .Cancel) { (action:UIAlertAction!) in
            //                self.gameFininshed = true
            //                self.initialiseBoardValues()
            //            }
            //            alertController.addAction(cancelAction)
            
            //            self.presentViewController(alertController, animated: true, completion:nil)
        } else if takenCellCount == (boardSize * boardSize) {
            // Hide player's turn label
//            infoLabel.hidden = true
            
            self.gameFininshed = true
            print("Its a Tie")
            
            //            saveGameResult(.Tie)
            
            //            let alertController = UIAlertController(title: "Game Over!", message: "It's a Tie", preferredStyle: .Alert)
            //
            //            let cancelAction = UIAlertAction(title: "Play Again", style: .Cancel) { (action:UIAlertAction!) in
            //                self.gameFininshed = true
            //                self.initialiseBoardValues()
            //            }
            //            alertController.addAction(cancelAction)
            //
            //            self.presentViewController(alertController, animated: true, completion:nil)
            //        }
        }
    }
    
    func switchPlayerTurn() -> Player? {
        if gameFininshed {
            return nil
        }
        
        currentPlayer = currentPlayer == .Player1 ? .Player2 : .Player1
//        let player = currentPlayer == .Player1 ? "Player 1" : "Player 2"
//        infoLabel.text = "\(player) to move"
        return currentPlayer
    }
}
