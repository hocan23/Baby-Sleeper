//
//  PlayerBrain.swift
//  Baby Sleeper
//
//  Created by Hasan onur Can on 12.08.2022.
//

import Foundation
import AVFAudio
import UIKit


class GSAudio: NSObject, AVAudioPlayerDelegate {
    
    static let sharedInstance = GSAudio()
    
    private override init() { }
    
    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []
    
    func playSound(soundFileName: String, volume: Float?=nil) {
        print(soundFileName)
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: "mp3") else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)
        print(players)
        if let player = players[soundFileNameURL] { //player for sound has been found
            
            if !player.isPlaying { //player is not in use, so use that one
                player.prepareToPlay()
                player.setVolume(volume ?? 1, fadeDuration: 0)
                player.play()
                
                player.numberOfLoops = -1
            } else { // player is in use, create a new, duplicate, player and use that instead
                
                do {
                    let duplicatePlayer = try AVAudioPlayer(contentsOf: soundFileNameURL)
                    
                    duplicatePlayer.delegate = self
                    //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing
                    
                    duplicatePlayers.append(duplicatePlayer)
                    //add duplicate to array so it doesn't get removed from memory before finishing
                    
                    duplicatePlayer.prepareToPlay()
                    player.setVolume(0.1, fadeDuration: 0)
                    
                    duplicatePlayer.play()
                } catch let error {
                    print(error.localizedDescription)
                }
                
            }
        } else { //player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                print(player)
                player.prepareToPlay()
                player.setVolume(volume ?? 1.0, fadeDuration: 0)
                //                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
                //                    print("Playback OK")
                //                    try AVAudioSession.sharedInstance().setActive(true)
                
                player.play()
                player.numberOfLoops = -1
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func playSounds(soundFiles: [BabyAudio]) {
        for soundFile in soundFiles {
            playSound(soundFileName: soundFile.musicName, volume: soundFile.musicVolume)
        }
    }
    func playSounds(soundFiles: BabyAudio...) {
        for soundFile in soundFiles {
            
            playSound(soundFileName: soundFile.musicName, volume: soundFile.musicVolume)
            
        }
    }
    func stopSounds(soundFiles: [BabyAudio]) {
        for soundFile in soundFiles {
            print(soundFile.musicName)
            self.stopSound(soundFileName: soundFile.musicName, volume: soundFile.musicVolume)
           
            
            
        }
       
    }
    func stopSound(soundFileName: String, volume: Float?=nil) {
        print(soundFileName)
        print(duplicatePlayers.count)
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: "mp3") else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)
        
        if let player = players[soundFileNameURL] { //player for sound has been found
            player.stop()
        }
        
        
        
        
    }
    func playSounds(soundFiles: [BabyAudio], withDelay: Double) { //withDelay is in seconds
        for (index, soundFile) in soundFiles.enumerated() {
            let delay = withDelay * Double(index)
            let _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(_:)), userInfo: ["fileName": soundFile.musicName], repeats: false)
        }
    }
    
    @objc func playSoundNotification(_ notification: NSNotification) {
        if let soundFileName = notification.userInfo?["fileName"] as? String {
            playSound(soundFileName: soundFileName)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = duplicatePlayers.index(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }
    
}
