//
//  HistoryViewController.swift
//  TicTacToe
//
//  Created by Sibin Baby on 20/07/2016.
//  Copyright © 2016 SibinBaby. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var player1WinsLabel: UILabel!
    @IBOutlet var player2WinsLabel: UILabel!
    @IBOutlet var drawCountLabel: UILabel!
    
    var history: GameHistory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1WinsLabel.text = history.player1WinCount > 1 ? "\(history.player1WinCount) times" : "\(history.player1WinCount) time"
        player2WinsLabel.text = history.player2WinCount > 1 ? "\(history.player2WinCount) times" : "\(history.player2WinCount) time"
        drawCountLabel.text = history.tieCount > 1 ? "\(history.tieCount) times" : "\(history.tieCount) time"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissPopUp(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
