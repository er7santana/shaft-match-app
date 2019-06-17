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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Called when the user select an item in collection View
        print("item at index \(indexPath) selected/tapped")
    }
    
}

