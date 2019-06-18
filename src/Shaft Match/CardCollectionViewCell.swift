//
//  CardCollectionViewCell.swift
//  Shaft Match
//
//  Created by Rodrigo Sant Ana on 17/06/19.
//  Copyright © 2019 Shaft Corporation. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card){
        self.card = card
        frontImageView.image = UIImage(named: card.imageName)
    }
    
    func flip() {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
    }
    
    func flipBack() {
        UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
    }
}
