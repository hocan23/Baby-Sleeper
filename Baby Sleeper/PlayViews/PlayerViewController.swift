//
//  PlayerViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/29/22.
//

import UIKit
import AVFAudio

class PlayerViewController: UIViewController ,AVAudioPlayerDelegate  {
    var player : AVAudioPlayer?
    var currentPlayList  : [BabyAudio] = []
    var allSounds = Utils.allSounds
    var allMusics = Utils.allMusics
    var vcType : String?


    
    @IBOutlet weak var mixImage: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var timer: UIImageView!
    @IBOutlet weak var removeAd: UIImageView!
    @IBOutlet weak var myMixesLabel: UILabel!
    @IBOutlet weak var playerCollection: UICollectionView!
    var isPlay = false
    let insets = UIEdgeInsets(top: 10, left: 15, bottom: 60, right: 15)
    let spacing = CGSize(width: 5, height: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        playerCollection.dataSource = self
        playerCollection.delegate = self 
        setupUi()
        playMusic(name: "Dream", type: "mp3")
        playMusica(name: "Fly", type: "mp3")
    }
    func setupUi(){
        myMixesLabel.isUserInteractionEnabled = true
        myMixesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myMixesLabelTapped)))
//        removeAd.isUserInteractionEnabled = true
//        removeAd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeAdTapped)))
        timer.isUserInteractionEnabled = true
        timer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(timerTapped)))
        playImage.isUserInteractionEnabled = true
        playImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playImageTapped)))
        mixImage.isUserInteractionEnabled = true
        mixImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mixImageTapped)))
        if vcType != "sound"{
            myMixesLabel.isHidden = true
            mixImage.isUserInteractionEnabled = false
        }
    }
    @objc func myMixesLabelTapped (){
        myMixesLabel.zoomIn()
    }
//    @objc func removeAdTapped (){
//        removeAd.zoomIn()
//    }
    @objc func timerTapped (){
        timer.zoomIn()
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
        destinationVC.modalPresentationStyle = .formSheet
        self.present(destinationVC, animated: true, completion: nil)
       
    }
    @objc func playImageTapped (){
        playImage.zoomIn()
        print(currentPlayList.count)
        if isPlay == false{
            playImage.image = UIImage(named: "pause")
            GSAudio.sharedInstance.playSounds(soundFiles: currentPlayList)
            Utils.setToMusicList(type: currentPlayList)

            isPlay = true
        }else{
            GSAudio.sharedInstance.stopSounds(soundFiles: currentPlayList)
            playImage.image = UIImage(named: "play")
            isPlay = false
        }
        


    }
    @objc func mixImageTapped (){
        mixImage.zoomIn()
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "MixViewController") as! MixViewController
        destinationVC.modalPresentationStyle = .pageSheet
        print(currentPlayList)
        destinationVC.playlist = currentPlayList
        self.present(destinationVC, animated: true, completion: nil)

    }
    
    
    public func playMusica (name:String,type:String){
        
        if let playera = player, playera.isPlaying{
//            playera.stop()
//            playView.image = UIImage(named: "playBtn")
//            animationView.isHidden=true
//            isAnimate = false
//             collectionAnimal.reloadData()
        }else{
//            homeAnimation(name: "detail3")
//            isAnimate = true
//             collectionAnimal.reloadData()
            let urlString = Bundle.main.path(forResource: name, ofType: type)
            
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlString = urlString else{
                    return
                }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player?.delegate = self
                
                guard let playera = player else{
                    return
                }
                playera.play()
                playera.numberOfLoops = -1
//                playView.image = UIImage(named: "pauseBtn")
                
            }
            catch{
                print("not work")
            }
        }
    }
    
    
    
    
    public func playMusic (name:String,type:String){
        
        if let player = player, player.isPlaying{
            player.stop()
//            playView.image = UIImage(named: "playBtn")
//            animationView.isHidden=true
//            isAnimate = false
//             collectionAnimal.reloadData()
        }else{
//            homeAnimation(name: "detail3")
//            isAnimate = true
//             collectionAnimal.reloadData()
            let urlString = Bundle.main.path(forResource: name, ofType: type)
            
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let urlString = urlString else{
                    return
                }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player?.delegate = self
                
                guard let player = player else{
                    return
                }
                player.play()
                player.numberOfLoops = -1
//                playView.image = UIImage(named: "pauseBtn")
                
            }
            catch{
                print("not work")
            }
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished")//It is working now! printed "finished"!
//        playMusic(name: "White Noise", type: "mp3")

//        playView.image = UIImage(named: "playBtn")
//        animationView.isHidden=true
//        if selectedItemNumber == cellIds.count-1{
//            selectedItemNumber = -1
//        }
//        if selectedItemNumber < cellIds.count-1{
//            if isAuto == true{
//                selectedItemNumber += 1
//                //                setupUi()
//                playMusic(name: cellIds[selectedItemNumber].letterSound, type: "mp3")
//                self.collectionAnimal.scrollToItem(at:IndexPath(item: selectedItemNumber, section: 0), at: .right, animated: false)
//            }
//        }else{
//            isAuto = false
//        }
//
    }

    @IBAction func homePressed(_ sender: UIButton) {
        GSAudio.sharedInstance.stopSounds(soundFiles: currentPlayList)
        player?.stop()
        dismiss(animated: true)
    }
}
extension PlayerViewController :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if vcType == "sound"{
            return Utils.allSounds.count

        }else{
            return Utils.allMusics.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playerCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PlayerCollectionViewCell
        if vcType == "sound"{
            cell.layer.cornerRadius = 20
            cell.imageView.image = UIImage(named: allSounds[indexPath.row].musicImage)
            cell.labelMusic.text = allSounds[indexPath.row].musicName
            if allSounds[indexPath.row].isPremium == true{
                cell.lockImage.isHidden = false

            }else{
                cell.lockImage.isHidden = true
            }
            if allSounds[indexPath.row].isSelected == true{
                cell.backgroundColor = UIColor(red: 140/255, green: 1, blue: 227/255, alpha: 100)
            }else{
                cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
            }
        }else{
            cell.layer.cornerRadius = 20
            cell.imageView.image = UIImage(named: allMusics[indexPath.row].musicImage)
            cell.labelMusic.text = allMusics[indexPath.row].musicName
            if allMusics[indexPath.row].isPremium == true{
                cell.lockImage.isHidden = false

            }else{
                cell.lockImage.isHidden = true
            }
            if allMusics[indexPath.row].isSelected == true{
                cell.backgroundColor = UIColor(red: 140/255, green: 1, blue: 227/255, alpha: 100)
            }else{
                cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
            }
        }
       
       
       
        
//        cell.layer.masksToBounds = false
//        cell.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
//        cell.layer.shadowOffset = CGSize(width: -3, height: 4)
//        cell.layer.shadowRadius = 10
//        cell.layer.shadowOpacity = 1
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if vcType == "sound"{
            if allSounds[indexPath.row].isPremium == true{
                
            }else{
            if allSounds[indexPath.row].isSelected == false{
                allSounds[indexPath.row].isSelected = true
                currentPlayList.append(allSounds[indexPath.row])
                GSAudio.sharedInstance.playSounds(soundFiles: currentPlayList)
                Utils.setToMusicList(type: currentPlayList)
                playImage.image = UIImage(named: "pause")
                isPlay = true
                
            }else{
                GSAudio.sharedInstance.stopSounds(soundFiles: currentPlayList)

                allSounds[indexPath.row].isSelected = false
                if currentPlayList.count == 1{
                    currentPlayList = []
                    playImage.image = UIImage(named: "play")
                    GSAudio.sharedInstance.stopSounds(soundFiles: currentPlayList)

                    isPlay=false
                }else{
                    currentPlayList = currentPlayList.filter({ $0.musicName != allSounds[indexPath.row].musicName})
                }
                
                print(currentPlayList.count)
                
                if currentPlayList.count > 0{
                GSAudio.sharedInstance.playSounds(soundFiles: currentPlayList)
                    Utils.setToMusicList(type: currentPlayList)

                    isPlay=true
                }else{
                    isPlay=false
                }
            }
            }
        }else{
            if allMusics[indexPath.row].isPremium == true{
                
            }else{
                GSAudio.sharedInstance.stopSounds(soundFiles: currentPlayList)
                playImage.image = UIImage(named: "play")
                currentPlayList = []
            if allMusics[indexPath.row].isSelected == false{
                allMusics = Utils.allMusics

                playImage.image = UIImage(named: "pause")
                isPlay=true
                allMusics[indexPath.row].isSelected = true
                currentPlayList.append(allMusics[indexPath.row])
                GSAudio.sharedInstance.playSounds(soundFiles: currentPlayList)
                Utils.setToMusicList(type: currentPlayList)


                
            }else{
                allMusics = Utils.allMusics

                allMusics[indexPath.row].isSelected = false
                isPlay=false
                GSAudio.sharedInstance.stopSounds(soundFiles: currentPlayList)

//                currentPlayList = currentPlayList.filter({ $0.musicName == allMusics[indexPath.row].musicName})
            }
            }
        }
        
        
        
        
        print(currentPlayList.count)
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        spacing.width
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            
            let numberOfVisibleCellHorizontal: CGFloat = 3
            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
            
            return CGSize(width: width, height: width)
            
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad  {
            
            let numberOfVisibleCellHorizontal: CGFloat = 5
            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
            
            return CGSize(width: width, height: width)
            
        }
        
        let numberOfVisibleCellHorizontal: CGFloat = 2
        let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
        let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
        
        return CGSize(width: width, height: width)
        
    }
    
}
