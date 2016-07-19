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
    
    let boardSize = 8
    var gameArray = [[GameCellItem]]()
    var gameFininshed = false
    var takenCellCount = 0
    var currentPlayer = Player.Player1
    var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Resize Cells to fit in the view
        let width = CGRectGetWidth(collectionView!.frame) / CGFloat(boardSize)
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        // Info label to display who's turn
        infoLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: view.bounds.size.height*3/4), size: CGSize(width: view.bounds.size.width, height: 100)))
        infoLabel.backgroundColor = UIColor.whiteColor()
        infoLabel.textColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        infoLabel.font = UIFont.boldSystemFontOfSize(30)
        infoLabel.textAlignment = NSTextAlignment.Center
        infoLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        infoLabel.text = "\(currentPlayer) 's turn"
        view.addSubview(infoLabel)
        
        let player1Label = UILabel(frame: CGRect(origin: CGPoint(x: 20, y: view.bounds.size.height - 40), size: CGSize(width: view.bounds.size.width/2, height: 40)))
        player1Label.backgroundColor = UIColor.whiteColor()
        player1Label.textColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        player1Label.font = UIFont.boldSystemFontOfSize(20)
        player1Label.textAlignment = NSTextAlignment.Left
        player1Label.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        player1Label.text = "Player1 : X"
        view.addSubview(player1Label)

        let player2Label = UILabel(frame: CGRect(origin: CGPoint(x: view.bounds.size.width/2 - 20, y: view.bounds.size.height - 40), size: CGSize(width: view.bounds.size.width/2, height: 40)))
        player2Label.backgroundColor = UIColor.whiteColor()
        player2Label.textColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        player2Label.font = UIFont.boldSystemFontOfSize(20)
        player2Label.textAlignment = NSTextAlignment.Right
        player2Label.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        player2Label.text = "Player2 : O"
        view.addSubview(player2Label)

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
        
        let gameCellItem = gameArray[indexPath.section][indexPath.row]
        cell.boxLabel.text = gameCellItem.title
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let gameCellItem = gameArray[indexPath.section][indexPath.row]
       
        // check if already selected
        if gameCellItem.isTaken {
            return
        }
        
        // Mark cell with corresponding indicator.
        gameCellItem.title = currentPlayer == .Player1 ? "X" : "O"
        gameCellItem.isTaken = true
        gameArray[indexPath.section][indexPath.row] = gameCellItem
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
        
        // Check if player won
        checkForWinForIndexPath(indexPath)
        
        // Switch players' turn
        switchPlayerTurn()
    }
    
    func checkForWinForIndexPath(indexPath: NSIndexPath) {
        let row = indexPath.section
        let column = indexPath.row
        print("Row:\(row), Column:\(column)")
        
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

        // Increment cell taken count.
        takenCellCount += 1
        
        if rowCheckWon || columnCheckWon || leftDiagonalWon || rightDiagonalWon {
            // Hide player's turn label
            infoLabel.hidden = true
            
            let info = "\(currentPlayer) has won"
            
            let alertController = UIAlertController(title: "Congratulations!", message: info, preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Play Again", style: .Cancel) { (action:UIAlertAction!) in
                self.gameFininshed = true
                self.reInitialiseBoard()
            }
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        } else if takenCellCount == (boardSize * boardSize) {
            // Hide player's turn label
            infoLabel.hidden = true
            
            let alertController = UIAlertController(title: "Oh!", message: "Looks like it is a tie", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Play Again", style: .Cancel) { (action:UIAlertAction!) in
                self.gameFininshed = true
                self.reInitialiseBoard()
            }
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
    func switchPlayerTurn() {
        if gameFininshed {
            return
        }
        print("changes player")
        currentPlayer = currentPlayer == .Player1 ? .Player2 : .Player1
        infoLabel.text = "\(currentPlayer) 's turn"
    }
    
    func reInitialiseBoard() {
        loadGameCellArray()
        // Reset current player
        currentPlayer = .Player1
        takenCellCount = 0
        gameFininshed = false
        collectionView?.reloadData()
        infoLabel.text = "\(currentPlayer) 's turn"
        infoLabel.hidden = false
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
    
    @IBAction func resetGame(sender: AnyObject) {
        reInitialiseBoard()
    }
}
