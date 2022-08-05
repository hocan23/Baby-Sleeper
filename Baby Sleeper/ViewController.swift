//
//  ViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/29/22.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController {

    
    
    @IBOutlet weak var headerBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var topStackBottomCons: NSLayoutConstraint!
    @IBOutlet weak var bottomStackTopCons: NSLayoutConstraint!
    
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var bottomStack: UIStackView!
    
    @IBOutlet weak var bottomStackTrailing: NSLayoutConstraint!
    @IBOutlet weak var bottomStackLeading: NSLayoutConstraint!
    @IBOutlet weak var topStackTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var topStackLeading: NSLayoutConstraint!
    
    @IBOutlet weak var bottomLeftLabelViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomRightLabelViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topRightLabelViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topLeftLabelViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomLeftBottomView: UIView!
    @IBOutlet weak var bottomRightBottomView: UIView!
    @IBOutlet weak var topRightBottomView: UIView!
    @IBOutlet weak var topLeftBottomView: UIView!
    @IBOutlet weak var removeAdView: UIImageView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var topLeftView: UIView!
    
    
    @IBOutlet weak var topLeftLabel: UILabel!
    
    @IBOutlet weak var topRightLabel: UILabel!
    
    @IBOutlet weak var bottomLeftLabel: UILabel!
    
    @IBOutlet weak var bottomRightLabel: UILabel!
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        // Do any additional setup after loading the view.
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
  
    func setupUi(){
        topLeftView.isUserInteractionEnabled = true
        topLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topLeftViewTapped)))
        topRightView.isUserInteractionEnabled = true
        topRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topRightViewTapped)))
        bottomLeftView.isUserInteractionEnabled = true
        bottomLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomLeftViewTapped)))
        bottomRightView.isUserInteractionEnabled = true
        bottomRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomRightViewTapped)))
        removeAdView.isUserInteractionEnabled = true
        removeAdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeTapped)))
        topLeftView.layer.cornerRadius = 20
        topRightView.layer.cornerRadius = 20
        bottomRightView.layer.cornerRadius = 20
        bottomLeftView.layer.cornerRadius = 20
        bottomRadius(view: topLeftBottomView)
        bottomRadius(view: topRightBottomView)
        bottomRadius(view: bottomLeftBottomView)
        bottomRadius(view: bottomRightBottomView)
        bottomLeftLabelViewHeight.constant = view.frame.height*0.075
        bottomRightLabelViewHeight.constant = view.frame.height*0.075
        topLeftLabelViewHeight.constant = view.frame.height*0.075
        topRightLabelViewHeight.constant = view.frame.height*0.075
        
        topLeftLabel.font = topLeftLabel.font.withSize(view.frame.height*0.025)
        topRightLabel.font = topRightLabel.font.withSize(view.frame.height*0.025)
        bottomLeftLabel.font = bottomLeftLabel.font.withSize(view.frame.height*0.025)
        bottomRightLabel.font = bottomRightLabel.font.withSize(view.frame.height*0.025)
        if UIDevice.current.userInterfaceIdiom == .pad  {
            topStackLeading.constant = 50
            topStackTrailing.constant = 50
            bottomStackLeading.constant = 50
            bottomStackTrailing.constant = 50
            topStack.setCustomSpacing(50, after: topStack.subviews[0])
            bottomStack.setCustomSpacing(50, after: bottomStack.subviews[0])
            bottomStackTopCons.constant = -30
            topStackBottomCons.constant = 80
            headerBottomCons.constant = 85
            view.overrideUserInterfaceStyle = .light

        }

    }
    func bottomRadius(view : UIView){
        view.clipsToBounds = true
            view.layer.cornerRadius = 20
        view.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    @objc func topLeftViewTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.vcType = "sound"
        self.present(destinationVC, animated: true, completion: nil)
    }
    @objc func topRightViewTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.vcType = "music"
        self.present(destinationVC, animated: true, completion: nil)
    }
    @objc func bottomLeftViewTapped (){
        bottomLeftView.zoomIn()
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "MixPlayerViewController") as! MixPlayerViewController
        destinationVC.modalPresentationStyle = .formSheet
        self.present(destinationVC, animated: true, completion: nil)
    
    }
    @objc func removeTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "RemoveViewController") as! RemoveViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    @objc func bottomRightViewTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
}

extension ViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
