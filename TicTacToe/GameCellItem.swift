//
//  GameCellItem.swift
//  TicTacToe
//
//  Created by Sibin Baby on 19/07/2016.
//  Copyright © 2016 SibinBaby. All rights reserved.
//

import UIKit

class GameCellItem {
    var title: String
    var isTaken: Bool
    
    init(title: String, isTaken: Bool) {
        self.title = title
        self.isTaken = isTaken
    }
}
