//
//  BoardSizeSelectionController.swift
//  TicTacToe
//
//  Created by Sibin Baby on 19/07/2016.
//  Copyright © 2016 SibinBaby. All rights reserved.
//

import UIKit

protocol BoardSizeSelectionDelegate: class {
    func didSelectBoardOfSize(boardSize: Int)
}

class BoardSizeSelectionController: UIViewController {

    weak var boardPickerDelegate: BoardSizeSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gridSelectionButtonPressed(sender: UIButton) {
        let boardSize: Int
        switch sender.tag {
        case 3:
            boardSize = 3
            break
        case 4:
            boardSize = 4
            break
        case 5:
            boardSize = 5
            break
        case 6:
            boardSize = 6
            break
        case 7:
            boardSize = 7
            break
        case 8:
            boardSize = 8
            break
        default:
            boardSize = 3
            break
        }
        
        print(boardSize)
        
        if let pickerDelagate = boardPickerDelegate {
            pickerDelagate.didSelectBoardOfSize(boardSize)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
