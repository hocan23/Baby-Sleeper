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
   
    static var fullScreenAdId = "ca-app-pub-1501030234998564/6651165302"
    static var  bannerId = "ca-app-pub-1501030234998564/6616356346"
    static var isPremium = ""
    static func saveLocal (array:[BabyAudio], key : String){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedAudio")
        }
}
    static func readLocal (key: String){
        if let savedAudio = UserDefaults.standard.object(forKey: "SavedAudio") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(BabyAudio.self, from: savedAudio) {
                print(loadedPerson)
            }
        }
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
  
    

}



class GSAudio: NSObject, AVAudioPlayerDelegate {

    static let sharedInstance = GSAudio()

    private override init() { }

    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    func playSound(soundFileName: String, volume: Float?=nil) {

        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: "mp3") else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

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
             
             stopSound(soundFileName: soundFile.musicName, volume: soundFile.musicVolume)
             
         }
     }
    func stopSound(soundFileName: String, volume: Float?=nil) {

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


