//
//  BoardViewController.swift
//  TicTacToe
//
//  Created by Sibin Baby on 19/07/2016.
//  Copyright © 2016 SibinBaby. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BoardCell"

class BoardViewController: UICollectionViewController {

    enum Player: Int {
        case Player1 = 0
        case Player2 = 1
    }
    
    let boardSize = 4
    var gameArray = [[String]]()
    var gameFininshed = false
    var turnCount = 0
    var currentPlayer = Player.Player1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Resize Cells to fit in the view
        let width = CGRectGetWidth(collectionView!.frame) / CGFloat(boardSize)
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        // Preload array with nil.
        reInitialiseBoard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return boardSize
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardSize
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BoardCollectionViewCell
        
        cell.boxLabel.text = ""
        
        let cellValue = gameArray[indexPath.section][indexPath.row]
        cell.boxLabel.text = cellValue
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        drawMarkForSpot(indexPath, player: currentPlayer)
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
    
    func drawMarkForSpot(indexPath: NSIndexPath, player: Player) {
        let playerMark = player == .Player1 ? "X" : "O"
        gameArray[indexPath.section][indexPath.row] = playerMark
        checkForWinForRow(indexPath.section, column: indexPath.row)
        switchTurn()
    }
    
    func checkForWinForRow(row: Int, column: Int) {
        var rowCheckWon = true
        var columnCheckWon = true
        var leftDiagonalWon = true
        var rightDiagonalWon = true
        
        for column in 0..<boardSize-1 {
            let first = gameArray[row][column]
            let second = gameArray[row][column + 1]
            if first != "" && first == second {
                continue
            } else {
                rowCheckWon = false
                break
            }
        }
        
        for row in 0..<boardSize-1 {
            let first = gameArray[row][column]
            let second = gameArray[row+1][column]
            if first != "" && first == second {
                continue
            } else {
                columnCheckWon = false
                break
            }
        }
        
        for i in 0..<boardSize-1 {
            let first = gameArray[i][i]
            let second = gameArray[i+1][i+1]
            if first != "" && first == second {
                continue
            } else {
                leftDiagonalWon = false
                break
            }
        }
        
        for i in 0..<boardSize-1 {
            let first = gameArray[boardSize-1-i][i]
            let second = gameArray[boardSize-2-i][i+1]
            if first != "" && first == second {
                continue
            } else {
                rightDiagonalWon = false
                break
            }
        }

        if rowCheckWon || columnCheckWon || leftDiagonalWon || rightDiagonalWon {
            print("\(currentPlayer) has won")
            gameFininshed = true
            reInitialiseBoard()
        } else {
            print("Not done yet")
        }
    }
    
    func switchTurn() {
        if gameFininshed {
            return
        }
        
        turnCount += 1
        currentPlayer = currentPlayer == .Player1 ? .Player2 : .Player1
    }
    
    func reInitialiseBoard() {
        // Empty all cells
        for row in 0..<boardSize {
            var rowArray = [String]()
            for column in 0..<boardSize {
                rowArray.insert("", atIndex: column)
            }
            gameArray.insert(rowArray, atIndex: row)
        }
        // Reset current player
        currentPlayer = .Player1
        turnCount = 0
        gameFininshed = false
        collectionView?.reloadData()
    }
    
    @IBAction func resetGame(sender: AnyObject) {
        reInitialiseBoard()
    }
}
