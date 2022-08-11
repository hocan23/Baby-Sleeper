//
//  PlayerViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/29/22.
//

import UIKit
import AVFAudio
import GoogleMobileAds

class PlayerViewController: UIViewController ,AVAudioPlayerDelegate,TimerStartProtocol  {
    
    @IBOutlet weak var setViewHeightConstraint: NSLayoutConstraint!
    var player : AVAudioPlayer?
    var currentPlayList  : [BabyAudio] = []
    var allSounds = Utils.allSounds
    var allMusics = Utils.allMusics
    var vcType : String?
    var timerCount:Int = 0
    var bannerView: GADBannerView!
    var isAd = false
    var timerss : Timer = Timer()
    private var interstitial: GADInterstitialAd?
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var bottomStackBottomConstat: NSLayoutConstraint!
    
    @IBOutlet weak var mixImage: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var timer: UIImageView!
    @IBOutlet weak var removeAd: UIImageView!
    @IBOutlet weak var myMixesLabel: UILabel!
    @IBOutlet weak var playerCollection: UICollectionView!
    var isPlay = false
    
        var insets = UIEdgeInsets(top: 10, left: 15, bottom: 60, right: 15)
        var spacing = CGSize(width: 5, height: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerCollection.dataSource = self
        playerCollection.delegate = self
        setupUi()
        timerLabel.isHidden = true
        mixImage.isUserInteractionEnabled = false
        if Utils.listMusic != nil{
            playImage.image = UIImage(named: "pause")
            isPlay = true
        }
        view.overrideUserInterfaceStyle = .light
        if UIDevice.current.userInterfaceIdiom == .pad  {
            insets = UIEdgeInsets(top: 10, left: 30, bottom: 60, right: 30)
            spacing = CGSize(width: 30, height: 30)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        if currentPlayList.isEmpty == false{
            Utils.listMusic = currentPlayList

        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .lightContent
        } else {
            return .default
        }
    }
    func timerStart(time: Int) {
        timerCount = time
        timerss.invalidate()
        if Utils.timerRemainCount == 0{
            timerLabel.isHidden=true
        }else{
        timerss = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounterr), userInfo: nil, repeats: true)
        }
        
        
        
 
    }

    @objc func timerCounterr(){
        self.timerCount -= 1
        print(timerCount)
        if self.timerCount == 0 {
            print("Go!")
            print(Utils.listMusic)
            GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])
            isPlay=false
                       self.playImage.image = UIImage(named: "play")
                       self.timerLabel.isHidden = true
            Utils.listMusic = nil
            Utils.timerRemainCount = 0
            timerss.invalidate()
          
        } else {
                self.timerLabel.isHidden = false

            print(self.timer)
            let watch = StopWatch(totalSeconds: self.timerCount)
            print(watch.simpleTimeString)
            let currentTime = watch.simpleTimeString
            
                            //self.dataLabel.setNeedsDisplay()
                self.timerLabel.text = "\(currentTime)"
                        
        }
    
    }
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    func setupUi(){
        mixImage.alpha = 0.25

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
            mixImage.alpha = 0.25
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true {
            GSAudio.sharedInstance.playSounds(soundFiles: Utils.listMusic ?? [])
            Utils.addTimer = 40
            self.dismiss(animated: true)
            
        }
        if Utils.isPremium == "premium"{
            setViewHeightConstraint.constant = 100
            bottomStackBottomConstat.constant = 49

        }else{
            createAdd()
            
            bannerView = GADBannerView(adSize: GADAdSizeBanner)
            bannerView.adUnitID = Utils.bannerId
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            bannerView.delegate = self
        }
        
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait

        }
    }
    @objc func myMixesLabelTapped (){
        myMixesLabel.zoomIn()
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "MixPlayerViewController") as! MixPlayerViewController
        destinationVC.modalPresentationStyle = .formSheet
        self.present(destinationVC, animated: true, completion: nil)
    }
    //    @objc func removeAdTapped (){
    //        removeAd.zoomIn()
    //    }
    @objc func timerTapped (){
        timer.zoomIn()
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
        destinationVC.delegate = self
        destinationVC.timerCount = timerCount
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
        if Utils.listMusic != nil && currentPlayList.count == 0{
            print(Utils.listMusic)
            GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic!)
            isPlay = false
            playImage.image = UIImage(named: "play")
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
        if Utils.addTimer <= 0{
        if interstitial != nil && currentPlayList.isEmpty == true {
            if isPlay == true{
                GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])

            }

            interstitial?.present(fromRootViewController: self)
            isAd = true
        } else {
            print("Ad wasn't ready")
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController

            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true, completion: nil)
        }
        }else{
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController

            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true, completion: nil)
        }
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
        if UIDevice.current.userInterfaceIdiom == .pad  {

        cell.labelMusic.font = cell.labelMusic.font.withSize(view.frame.height*0.017)
        }
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
        GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])
        
        if vcType == "sound"{
            
            
        
            
            if allSounds[indexPath.row].isPremium == true{
                
             
//                if interstitial != nil && currentPlayList.isEmpty == true {
//                    if isPlay == true{
//                        GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])
//
//                    }
//
//                    interstitial?.present(fromRootViewController: self)
//                    isAd = true
//                } else {
//                    print("Ad wasn't ready")
//                    self.dismiss(animated: true)
//                }
            
                
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "RemoveViewController") as! RemoveViewController
                destinationVC.isComeFromPlayer = vcType!

                destinationVC.modalPresentationStyle = .fullScreen
                self.present(destinationVC, animated: true, completion: nil)
            }else{
                if allSounds[indexPath.row].isSelected == false{
                    allSounds[indexPath.row].isSelected = true
                    currentPlayList.append(allSounds[indexPath.row])
                    GSAudio.sharedInstance.playSounds(soundFiles: currentPlayList)
                    Utils.setToMusicList(type: currentPlayList)
                    playImage.image = UIImage(named: "pause")
                    isPlay = true
                    mixImage.alpha = 1
                    mixImage.isUserInteractionEnabled = true
                }else{
                    allSounds[indexPath.row].isSelected = false
                    
                    GSAudio.sharedInstance.stopSounds(soundFiles: currentPlayList)
                    
                    if currentPlayList.count == 1{
                        currentPlayList = []
                        playImage.image = UIImage(named: "play")
                        GSAudio.sharedInstance.stopSound(soundFileName: allSounds[indexPath.row].musicName)
                        isPlay=false
                    }else{
                        currentPlayList = currentPlayList.filter({ $0.musicName != allSounds[indexPath.row].musicName})
                    }
                    
                    print(currentPlayList.count)
                    
                    if currentPlayList.count > 0{
                        GSAudio.sharedInstance.playSounds(soundFiles: currentPlayList)
                        Utils.setToMusicList(type: currentPlayList)
                        mixImage.alpha = 1
                        isPlay=true
                        mixImage.isUserInteractionEnabled = true

                    }else{
                        mixImage.alpha = 0.25
                        isPlay=false
                        mixImage.isUserInteractionEnabled = false

                    }
                }
            }
        }else{
            if allMusics[indexPath.row].isPremium == true{
                
               
//                if interstitial != nil && currentPlayList.isEmpty == true {
//                    if isPlay == true{
//                        GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])
//
//                    }
//
//                    interstitial?.present(fromRootViewController: self)
//                    isAd = true
//                } else {
//                    print("Ad wasn't ready")
//                    self.dismiss(animated: true)
//                }
            
                
                
                
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "RemoveViewController") as! RemoveViewController
                destinationVC.isComeFromPlayer = vcType!
                destinationVC.modalPresentationStyle = .fullScreen
                self.present(destinationVC, animated: true, completion: nil)
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
            
            let numberOfVisibleCellHorizontal: CGFloat = 4
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

extension StopWatch {
    
    var simpleTimeString: String {
        let hoursText = timeText(from: hours)
        let minutesText = timeText(from: minutes)
        let secondsText = timeText(from: seconds)
        return "\(hoursText):\(minutesText):\(secondsText)"
    }
    
    private func timeText(from number: Int) -> String {
        return number < 10 ? "0\(number)" : "\(number)"
    }
}
extension PlayerViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
    func createAdd() {
        let request = GADRequest()
        interstitial?.fullScreenContentDelegate = self
        GADInterstitialAd.load(withAdUnitID:Utils.fullScreenAdId,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
        }
        )
    }
    func interstitialWillDismissScreen(_ ad: GADInterstitialAd) {
        print("interstitialWillDismissScreen")
    }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        // Add banner to view and add constraints as above.
        addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}
