//
//  MixViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/30/22.
//

import UIKit
import AVFoundation
import GoogleMobileAds

protocol DeleteAudio{
    func deleteAudio(selectedNumber:Int)
}

class MixViewController: UIViewController   {
    var player : AVAudioPlayer?
    var playlistLocale : [String]?
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var table: UITableView!
    var playlist : [BabyAudio]?
    var bannerView: GADBannerView!
    var inde : Int?
    var delegate : DeleteAudio?
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
       
        table.separatorStyle = .none
        closeButton.layer.cornerRadius = 20
        saveButton.layer.cornerRadius = 20
        playlistLocale = Utils.readLocalList(key: "list")
        view.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Utils.isPremium == "premium"{
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .lightContent
        } else {
            return .default
        }
    }
    
    func alert (){
        let alertController = UIAlertController(title: "Mixes Name?", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Name"
        }
        
        
        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
           
            let inputName = alertController.textFields![0].text
            self.playlistLocale?.append(inputName ?? "")
            Utils.saveLocalList(array: self.playlistLocale ?? [], key: "list")
            Utils.saveLocal(array: self.playlist ?? [], key: inputName ?? "")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
                present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        saveButton.zoomIn()
        alert()
        
    }
    
    @IBAction func closedTapped(_ sender: Any) {
        closeButton.zoomIn()
        dismiss(animated: true)
    }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        print(sender.value)
        playlist?[sender.tag].musicVolume = sender.value
        GSAudio.sharedInstance.stopSound(soundFileName: playlist![sender.tag].musicName)
        playlist?[sender.tag].musicVolume = sender.value
        GSAudio.sharedInstance.playSound(soundFileName:  playlist![sender.tag].musicName,volume:  playlist![sender.tag].musicVolume)
        
    }
   
    
    @IBAction func deletetap(_ sender: UIButton) {
        print(sender.tag)
        delegate?.deleteAudio(selectedNumber: sender.tag)
        GSAudio.sharedInstance.stopSound(soundFileName: playlist![sender.tag].musicName)
        playlist?.remove(at: sender.tag)
        table.reloadData()
       
       
    }
    
}

extension MixViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(playlist?.count)
        return playlist?.count ?? 0    // 2 rows in the cell, for demo purposes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MixesTableViewCell
        cell.selectionStyle = .default
        cell.deleteBtn.tag = indexPath.row

        cell.labelTxt.text = playlist?[indexPath.row].musicName
        cell.slider.tag = indexPath.row
        cell.slider.setValue(playlist?[indexPath.row].musicVolume ?? 1, animated: true)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

extension MixViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
