//
//  SoundManager.swift
//  Shaft Match
//
//  Created by Rodrigo Sant Ana on 19/06/19.
//  Copyright © 2019 Shaft Corporation. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    static func playSound(_ effect:SoundEffect) {
        
        var soundFileName = ""
        
        switch effect {
        case .flip:
            soundFileName = "cardflip"
        case .shuffle:
            soundFileName = "shuffle"
        case .match:
            soundFileName = "dingcorrect"
        case .nomatch:
            soundFileName = "dingwrong"
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't find sound file \(soundFileName) in the bundle")
            return
        }
        
        let soundUrl = URL(fileURLWithPath: bundlePath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.play()
        }
        catch {
            print("Couldn't create Audio Player object for sound file \(soundFileName)")
        }
    }
}
