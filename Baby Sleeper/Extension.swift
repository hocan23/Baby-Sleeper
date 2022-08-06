//
//  Extension.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/29/22.
//

import Foundation
import UIKit
import AVFoundation
struct BabyAudio: Codable {
    var musicName : String
    var musicImage : String
    var musicVolume : Float
    var isPremium : Bool
    var isSelected : Bool
}

extension UIView{
    
    func zoomIn(duration: TimeInterval = 0.4) {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    func anchor(top : NSLayoutYAxisAnchor?,
                bottom : NSLayoutYAxisAnchor?,
                leading : NSLayoutXAxisAnchor?,
                trailing : NSLayoutXAxisAnchor?,
                paddingTop : CGFloat,
                paddingBottom : CGFloat,
                paddingLeft : CGFloat,
                paddingRight : CGFloat,
                width : CGFloat,
                height : CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
}

class Utils{
    
    static var fullScreenAdId = "ca-app-pub-3940256099942544/44114689"
    static var  bannerId = "ca-app-pub-3940256099942544/29347357"
    static var isPremium = ""
    static var listMusic :[BabyAudio]?
    static var timerCount = 0
    static func setToMusicList(type:[BabyAudio]){
        Utils.listMusic = type
    }
    static func saveLocal (array:[BabyAudio], key : String){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    static func readLocale (key: String)->[BabyAudio]{
        var array : [BabyAudio] = []

        if let savedAudio = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode([BabyAudio].self, from: savedAudio) {
                print(loadedPerson)
                array=loadedPerson
            }

        }
        return array

    }
    static func saveLocal (array:String, key : String){
        let defaults = UserDefaults.standard
        defaults.set(array, forKey: key)
    }
    static func readLocal (key: String)->String{
        let defaults = UserDefaults.standard
        let myarray = defaults.string(forKey: key) ?? String()
        return myarray
    }
    static func saveLocalList (array:[String], key : String){
        let defaults = UserDefaults.standard
        defaults.set(array, forKey: key)
    }
    static func readLocalList (key: String)->[String]{
        let defaults = UserDefaults.standard
        let myarray = defaults.stringArray(forKey: "list") ?? [String]()
        return myarray
    }
    
    static var allSounds : [BabyAudio] = [
        BabyAudio(musicName: "White Noise", musicImage: "White Noise", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Pink Noise", musicImage: "Pink Noise", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Brown Noise", musicImage: "Brown Noise", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Shush", musicImage: "Shush", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Hair Dryer", musicImage: "Hair Dryer", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Vacuum Cleaner", musicImage: "Vacuum Cleaner", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Rain", musicImage: "Rain", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Rain & Thunder", musicImage: "Rain & Thunder", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Car Ride", musicImage: "Car Ride", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Birds", musicImage: "Birds", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Sea Wave", musicImage: "Sea Wave", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Cat Purring", musicImage: "Cat Purring", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Night Crickets", musicImage: "Night Crickets", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Mother Heartbeat", musicImage: "Mother Heartbeat", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Deep Sea", musicImage: "Deep Sea", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Table Fan", musicImage: "Table Fan", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Stream", musicImage: "Stream", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Supermarket", musicImage: "Supermarket", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Forest", musicImage: "Forest", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Cold Wind", musicImage: "Cold Wind", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Train", musicImage: "Train", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Bonfire", musicImage: "Bonfire", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Wall Clock", musicImage: "Wall Clock", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Water Drop", musicImage: "Water Drop", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Stew", musicImage: "Stew", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Snow Storm", musicImage: "Snow Storm", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Cabin", musicImage: "Cabin", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Space", musicImage: "Space", musicVolume: 1, isPremium: true, isSelected: false),
        
        
        BabyAudio(musicName: "Street", musicImage: "Street", musicVolume: 1, isPremium: true, isSelected: false),
        
        BabyAudio(musicName: "Purl", musicImage: "Purl", musicVolume: 1, isPremium: true, isSelected: false)
        
    ]
    
    
    
    static var allMusics : [BabyAudio] = [
        BabyAudio(musicName: "Far Away", musicImage: "Far Away", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "History", musicImage: "History", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Infinity", musicImage: "Infinity", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Memories", musicImage: "Memories", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Peace", musicImage: "Peace", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Sky", musicImage: "Sky", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Soul", musicImage: "Soul", musicVolume: 1, isPremium: false, isSelected: false),
        BabyAudio(musicName: "Dream", musicImage: "Dream", musicVolume: 1, isPremium: true, isSelected: false),
        
        BabyAudio(musicName: "Fly", musicImage: "Fly", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Life", musicImage: "Life", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Love", musicImage: "Love", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Rainbow", musicImage: "Rainbow", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Relax", musicImage: "Relax", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Silence", musicImage: "Silence", musicVolume: 1, isPremium: true, isSelected: false),
        BabyAudio(musicName: "Star", musicImage: "Star", musicVolume: 1, isPremium: true, isSelected: false)
    ]
    
    
}



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


