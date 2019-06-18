//
//  ViewController.swift
//  Shaft Match
//
//  Created by Rodrigo Sant Ana on 17/06/19.
//  Copyright © 2019 Shaft Corporation. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardModel = CardModel()
    var cards = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cards = cardModel.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - UICollectionView Protocols Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        cell.setCard(cards[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentCard = cards[indexPath.row]
        let currentCell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        if !currentCard.isFlipped && !currentCard.isMatched {
            currentCell.flip()
            currentCard.isFlipped = true
            
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else {
                
                let firstCard = cards[firstFlippedCardIndex!.row]
                let firstCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
                
                if firstCard.imageName == currentCard.imageName {
                    
                    firstCard.isMatched = true
                    currentCard.isMatched = true
                    
                    firstCell?.remove()
                    currentCell.remove()
                }
                else {
                    firstCell?.flipBack()
                    firstCard.isFlipped = false
                    currentCell.flipBack()
                    currentCard.isFlipped = false
                }
                
                if firstCell == nil {
                    collectionView.reloadItems(at: [firstFlippedCardIndex!])
                }
                firstFlippedCardIndex = nil
            }
        }
        
    }
    
}

