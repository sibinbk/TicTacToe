//
//  GameHistory.swift
//  TicTacToe
//
//  Created by Sibin Baby on 20/07/2016.
//  Copyright © 2016 SibinBaby. All rights reserved.
//

import UIKit

class GameHistory {    
    var player1WinCount: Int
    var player2WinCount: Int
    var tieCount: Int
    
    init(player1WinCount: Int, player2WinCount: Int, drawCount: Int) {
        self.player1WinCount = player1WinCount
        self.player2WinCount = player2WinCount
        self.tieCount = tieCount
    }
}
