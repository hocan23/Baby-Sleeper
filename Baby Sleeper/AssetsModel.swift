//
//  AssetsModel.swift
//  Baby Sleeper
//
//  Created by Hasan onur Can on 12.08.2022.
//

import Foundation

struct BabyAudio: Codable,Equatable {
    var musicName : String
    var musicImage : String
    var musicVolume : Float
    var isPremium : Bool
    var isSelected : Bool

    
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

struct StopWatch {
    
    var totalSeconds: Int
    
    var years: Int {
        return totalSeconds / 31536000
    }
    
    var days: Int {
        return (totalSeconds % 31536000) / 86400
    }
    
    var hours: Int {
        return (totalSeconds % 86400) / 3600
    }
    
    var minutes: Int {
        return (totalSeconds % 3600) / 60
    }
    
    var seconds: Int {
        return totalSeconds % 60
    }
    
    //simplified to what OP wanted
    var hoursMinutesAndSeconds: (hours: Int, minutes: Int, seconds: Int) {
        return (hours, minutes, seconds)
    }
}
