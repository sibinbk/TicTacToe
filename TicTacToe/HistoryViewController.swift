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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissPopUp(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
