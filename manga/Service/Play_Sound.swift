//
//  Play_Sound.swift
//  manga
//
//  Created by Apple on 25/09/2021.
//


import UIKit
import AVFoundation

class PlaySoundService: NSObject {
    static let shared:PlaySoundService = PlaySoundService()
    var player = AVAudioPlayer()
    func loadInit(){
        guard let path = Bundle.main.path(forResource: "dat", ofType: "m4a") else {
                    return
                }
                //Tạo url từ đường dẫn
                guard let url = URL(string: path) else {
                    return
                }
                //Set đường dẫn audio cho AVAudioPlayer
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                } catch {
                    //Error
                }
        player.numberOfLoops = -1
    }
    func playSound() {
        player.play()
    }
    
    func StopPlayer(){
        player.pause()
    }

}
