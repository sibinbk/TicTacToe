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

    var boardSize = 3
    var gameArray = [[String?]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = CGRectGetWidth(collectionView!.frame) / CGFloat(boardSize)
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        for _ in 0..<boardSize {
            var rowArray = [String?]()
            for _ in 0..<boardSize {
                rowArray.append(nil)
            }
            gameArray.append(rowArray)
        }
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
        
        if let cellValue = gameArray[indexPath.section][indexPath.row] {
            cell.boxLabel.text = cellValue
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        gameArray[indexPath.section][indexPath.row] = "X"
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
}
