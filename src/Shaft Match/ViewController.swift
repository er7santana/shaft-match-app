//
//  ViewController.swift
//  Shaft Match
//
//  Created by Rodrigo Sant Ana on 17/06/19.
//  Copyright © 2019 Shaft Corporation. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardModel = CardModel()
    var cards = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    var timer:Timer?
    var milliseconds:Float = 57 * 1000
    
    func startGame() {
        timerLabel.textColor = UIColor.black
        milliseconds = 57 * 1000
        firstFlippedCardIndex = nil
        cards = cardModel.getCards()
        
        collectionView.reloadData()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }
    
    @objc func timerElapsed() {
        milliseconds -= 1
        
        //Convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        timerLabel.text = "Time remaining: \(seconds)"
        
        if milliseconds <= 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            checkGameEnded()
        }
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
        
        if milliseconds <= 0 {
            return
        }
        
        let currentCard = cards[indexPath.row]
        let currentCell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        if !currentCard.isFlipped && !currentCard.isMatched {
            currentCell.flip()
            currentCard.isFlipped = true
            
            if firstFlippedCardIndex == nil {
                
                SoundManager.playSound(.flip)
                firstFlippedCardIndex = indexPath
            }
            else {
                
                let firstCard = cards[firstFlippedCardIndex!.row]
                let firstCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
                
                if firstCard.imageName == currentCard.imageName {
                    
                    firstCard.isMatched = true
                    currentCard.isMatched = true
                    
                    SoundManager.playSound(.match)
                    
                    firstCell?.remove()
                    currentCell.remove()
                    
                    checkGameEnded()
                }
                else {
                    
                    SoundManager.playSound(.nomatch)
                    
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
    
    func showAlert(_ title: String, _ message: String) {
        //Show won/lost messages
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Play again", style: .default, handler: {action -> Void in self.startGame()})
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkGameEnded() -> Void {
        
        //Determine weather there are unmatched cards left
        var isWon = true
        
        for item in cards {
            if !item.isMatched {
                isWon = false
                break
            }
        }
        
        var title = ""
        var message = ""
        
        if isWon {
            //The user has Won, stop the timer
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congratulations!"
            message = "You've won"
        }
        else {
            //If there are unmatched cards, check if there is any time left
            if milliseconds > 0 {
                return
            }
            
            title = "Game over"
            message = "You've lost"
            
        }
        
        showAlert(title, message)
    }
}

