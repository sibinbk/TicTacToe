//
//  BoardViewController.swift
//  TicTacToe
//
//  Created by Sibin Baby on 19/07/2016.
//  Copyright © 2016 SibinBaby. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BoardCell"
private let gridSegueIdentifier = "GridSelectionSegue"
private let historySegueIdentifier = "HistoryViewSegue"

class BoardViewController: UICollectionViewController, BoardSizeSelectionDelegate {
    var gameHistory: GameHistory!
    var boardSize = 3
    var infoLabel: UILabel!
    let gameController = GameLogicController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Default board size is # 3
        drawBoardOfSize(boardSize)
        
        // Read Game History.
        gameHistory = loadGameHistory()
    }

    func drawBoardOfSize(size: Int) {
        //Set board size.
        boardSize = size
        
        // Set Game Controller board size.
        gameController.boardSize = size
        
        // Resize Cells to fit in the view
        let width = CGRectGetWidth(collectionView!.frame) / CGFloat(boardSize)
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        // Set UI Elements on top of view.
        setUpTurnInfoLabel()
        setUpResetButton()
        setUpGdridSelectionButton()
        setupGameHistoryButton()
        setUpResetHistoryButton()
        
        // Preload array with empty cell items.
        initialiseBoardValues()
    }
    
    func setUpTurnInfoLabel() {
        // Info label to display who's turn
        infoLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: view.bounds.size.width + 74), size: CGSize(width: view.bounds.size.width, height: 40)))
        infoLabel.backgroundColor = UIColor.whiteColor()
        infoLabel.textColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
        infoLabel.font = UIFont.boldSystemFontOfSize(24)
        infoLabel.textAlignment = NSTextAlignment.Center
        infoLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        view.addSubview(infoLabel)
    }
    
    func setUpResetButton() {
        let button = UIButton()
        button.setTitle("Reset Game", forState: UIControlState.Normal)
        button.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(BoardViewController.resetGame(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
        let heightConstraint = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40)
        button.addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 140)
        button.addConstraint(widthConstraint)
        
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 80)
        self.view.addConstraint(centerXConstraint)
        
        let bottomConstraint = NSLayoutConstraint( item: button, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -70)
        self.view.addConstraint(bottomConstraint)
    }
    
    func setUpGdridSelectionButton() {
        let button = UIButton()
        button.setTitle("Select Grid", forState: UIControlState.Normal)
        button.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(BoardViewController.selectGridSize(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
        let heightConstraint = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40)
        button.addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 140)
        button.addConstraint(widthConstraint)
        
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: -80)
        self.view.addConstraint(centerXConstraint)
        
        let bottomConstraint = NSLayoutConstraint( item: button, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -70)
        self.view.addConstraint(bottomConstraint)
    }
    
    func setupGameHistoryButton() {
        let button = UIButton()
        button.setTitle("Game History", forState: UIControlState.Normal)
        button.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(BoardViewController.showPlayHistory(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
        let heightConstraint = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40)
        button.addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 140)
        button.addConstraint(widthConstraint)
        
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 80)
        self.view.addConstraint(centerXConstraint)
        
        let bottomConstraint = NSLayoutConstraint( item: button, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -20)
        self.view.addConstraint(bottomConstraint)
    }
    
    func setUpResetHistoryButton() {
        let button = UIButton()
        button.setTitle("Delete History", forState: UIControlState.Normal)
        button.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(BoardViewController.deleteGameHistory(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
        let heightConstraint = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40)
        button.addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 140)
        button.addConstraint(widthConstraint)
        
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: -80)
        self.view.addConstraint(centerXConstraint)
        
        let bottomConstraint = NSLayoutConstraint( item: button, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -20)
        self.view.addConstraint(bottomConstraint)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : - User Action methods.
    
    func resetGame(sender: UIButton) {
        initialiseBoardValues()
    }
    
    func selectGridSize(sender: UIButton) {
        performSegueWithIdentifier(gridSegueIdentifier, sender: nil)
    }
    
    func showPlayHistory(sender: UIButton) {
        performSegueWithIdentifier(historySegueIdentifier, sender: nil)
    }
    
    func deleteGameHistory(sender: UIButton) {
        let alertController = UIAlertController(title: "Delete History!", message: "Are you sure?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Yes", style: .Default) { (action:UIAlertAction!) in
            self.resetSavedData()
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
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
        
        cell.boxLabel.text = gameController.cellTitleForIndexPath(indexPath)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        // Exit if update cell fails.
        guard let _ = gameController.updateIfEmptyCellAtIndexPath(indexPath) else { return }
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
        
        // Check if player won
        let gameResult = gameController.checkForWinForIndexPath(indexPath)
        
        switch gameResult {
        case .Player1Won:
            infoLabel.hidden = true
            gameHistory.player1WinCount += 1
            saveGameResult(gameHistory.player1WinCount, key: "Player1WinCount")
            announceResult("Player 1 Won")
        case .Player2Won:
            infoLabel.hidden = true
            gameHistory.player2WinCount += 1
            saveGameResult(gameHistory.player2WinCount, key: "Player2WinCount")
            announceResult("Player 2 Won")
        case .Tie:
            infoLabel.hidden = true
            gameHistory.tieCount += 1
            saveGameResult(gameHistory.tieCount, key: "TieCount")
            announceResult("It's a Tie")
        case .NotFinished:
            infoLabel.hidden = false
            infoLabel.text = gameController.nextPlayer() == .Player1 ? "Player 1 to move" : "Player 2 to move"
        }
    }
    
    func announceResult(message: String) {
        let alertController = UIAlertController(title: "Game Over!", message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Play Again", style: .Cancel) { (action:UIAlertAction!) in
            self.initialiseBoardValues()
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion:nil)
    }
    
    func saveGameResult(resultCount: Int, key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(resultCount, forKey: key)
        defaults.synchronize()
    }
    
    func loadGameHistory() -> GameHistory {
        let defaults = NSUserDefaults.standardUserDefaults()
        let player1Count = defaults.integerForKey("Player1WinCount")
        let player2Count = defaults.integerForKey("Player2WinCount")
        let tieCount = defaults.integerForKey("TieCount")
        let history = GameHistory(player1WinCount: player1Count, player2WinCount: player2Count, tieCount: tieCount)
        return history
    }
    
    func resetSavedData() {
        // Reset game history object.
        gameHistory.player1WinCount = 0
        gameHistory.player2WinCount = 0
        gameHistory.tieCount = 0
        
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func initialiseBoardValues() {
        gameController.reInitialize()
        
        collectionView?.reloadData()
        infoLabel.text = "Player 1 to move"
        infoLabel.hidden = false
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == gridSegueIdentifier {
            if let destination = segue.destinationViewController as? BoardSizeSelectionController {
                destination.boardPickerDelegate = self
            }
        }
        
        if segue.identifier == historySegueIdentifier {
            if let destination = segue.destinationViewController as? HistoryViewController {
                destination.history = gameHistory
            }
        }
    }
    
    // MARK: BoardSizeSelectionDelegate
    
    func didSelectBoardOfSize(size: Int) {
        drawBoardOfSize(size)
    }
}
