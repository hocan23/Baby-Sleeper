//
//  Extension.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/29/22.
//

import Foundation
import UIKit
import AVFoundation


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
    
    static var fullScreenAdId = "ca-app-pub-1501030234998564/9882078815"
    static var  bannerId = "ca-app-pub-1501030234998564/3508242153"
    static var isPremium = ""
    static var listMusic :[BabyAudio]?
    static var timerCount = 0
    static var timerRemainCount = 0
    static var addTimer = 0
    static var addShow = false

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
    static func getStringToDateReferanslar(dateStr:String) -> Date {
        var retDate = Date()
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateSplit = dateStr.split(separator: "-")
        let date = dateFormatterGet.date(from: String(dateSplit[0]))
        let dateFormatter = DateFormatter()
        let editDateStr = dateFormatter.string(from: date!)
        retDate = dateFormatterGet.date(from: editDateStr) ?? Date()
        
        return retDate
    }
    
    static func dateFormatforHolidays(dateStr:Date) -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "yyyy-MM-dd"
        // again convert your date to string
        let myStringDate = formatter.string(from: yourDate!)
        
        return myStringDate
        
    }
}

class MyGlobalTimer: NSObject {

    let sharedTimer: MyGlobalTimer = MyGlobalTimer()
    var internalTimer: Timer?

    func startTimer(){
        guard self.internalTimer != nil else {
            fatalError("Timer already intialized, how did we get here with a singleton?!")
        }
        self.internalTimer = Timer.scheduledTimer(timeInterval: 1.0 /*seconds*/, target: self, selector: #selector(fireTimerAction), userInfo: nil, repeats: true)
    }

    func stopTimer(){
        guard self.internalTimer != nil else {
            fatalError("No timer active, start the timer before you stop it.")
        }
        self.internalTimer?.invalidate()
    }

    @objc func fireTimerAction(sender: AnyObject?){
        debugPrint("Timer Fired! \(sender)")
    }

}




