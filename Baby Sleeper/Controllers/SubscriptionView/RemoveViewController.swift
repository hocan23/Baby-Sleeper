//
//  RemoveViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 8/1/22.
//

import UIKit
import StoreKit
import GoogleMobileAds
class RemoveViewController: UIViewController {
    
    @IBOutlet weak var mounthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var lifeTimeLabel: UILabel!
    @IBOutlet weak var mountPriceLabel: UILabel!
    @IBOutlet weak var yearPriceLabel: UILabel!
    @IBOutlet weak var lfitimePriceLabel: UILabel!
    
    @IBOutlet weak var privacyyLabel: UILabel!
    @IBOutlet weak var firstLineWidth: NSLayoutConstraint!
    @IBOutlet weak var getProWidth: NSLayoutConstraint!
    
    @IBOutlet weak var restoreTopCons: NSLayoutConstraint!
    @IBOutlet weak var getProHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomPrivacyTopCons: NSLayoutConstraint!
    
    @IBOutlet weak var babyImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textviewHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollHeihgt: NSLayoutConstraint!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var unlockLabel: UILabel!
    @IBOutlet weak var removeLabel: UILabel!
    @IBOutlet weak var restoreWidth: NSLayoutConstraint!
    @IBOutlet weak var midTopConstant: NSLayoutConstraint!
    @IBOutlet weak var bottomTopConstant: NSLayoutConstraint!
    @IBOutlet weak var thirdLineHeight: NSLayoutConstraint!
    @IBOutlet weak var secondLineHeight: NSLayoutConstraint!
    @IBOutlet weak var firstLineHeight: NSLayoutConstraint!
    @IBOutlet weak var leftSidesWidth: NSLayoutConstraint!
    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var midRightView: UIView!
    @IBOutlet weak var midLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var topLeftView: UIView!
    var bannerView: GADBannerView!
    var isAd = false
    var isComeFromPlayer = ""
    private var interstitial: GADInterstitialAd?
    var models = [SKProduct]()
    //    var timerAdd : Timer = Timer()
    //    var timerAddCount = 10
    
    enum Products : String,CaseIterable{
        case mounthlyPro = "com.SIX11.babySlepper1month"
        case lifeTimePro = "com.SIX11.babySleeperLifeTime"
        case yearlyPro = "com.SIX11.babySleeper1year"
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        timerAdd.invalidate()
        //        timerAdd = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addCounterr), userInfo: nil, repeats: true)
        Utils.isPremium = Utils.readLocal(key: "purchase")
        SKPaymentQueue.default().add(self)
        setupUi()
        let a = Utils.readLocal(key: "nextMounth").suffix(26)
        print(a.prefix(19))
        let b = String(a.prefix(19)) as String
        var retDate = Date()
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        retDate = dateFormatterGet.date(from: b) ?? Date()
        if retDate<=Date(){
            SKPaymentQueue.default().restoreCompletedTransactions()
            
        }
        firstLineWidth.constant = view.frame.width * 0.6
        if let top
            = UIApplication.shared.windows.first?.safeAreaInsets.top
        {
            scrollView.contentInset.top = -top
            restoreTopCons.constant = 40+top
        }
        if let bottom
            = UIApplication.shared.windows.first?.safeAreaInsets.bottom
        {
            scrollView.contentInset.bottom = -bottom
        }
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.bounces = false
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true {
            GSAudio.sharedInstance.playSounds(soundFiles: Utils.listMusic ?? [])
            Utils.addTimer = 40
            if isComeFromPlayer == "sound" || isComeFromPlayer == "music" {
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                destinationVC.modalPresentationStyle = .fullScreen
                destinationVC.vcType = isComeFromPlayer
                self.present(destinationVC, animated: true, completion: nil)
            }else if isComeFromPlayer == "settings"{
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                destinationVC.modalPresentationStyle = .fullScreen
                self.present(destinationVC, animated: true, completion: nil)
            }else{
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                destinationVC.modalPresentationStyle = .fullScreen
                
                self.present(destinationVC, animated: true, completion: nil)
            }
            
        }
        print(Utils.isPremium )
        if Utils.isPremium == "premium"{
            //            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            //            destinationVC.modalPresentationStyle = .fullScreen
            //
            //            self.present(destinationVC, animated: true, completion: nil)
        }else{
            createAdd()
            
            bannerView = GADBannerView(adSize: GADAdSizeBanner)
            bannerView.adUnitID = Utils.bannerId
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            bannerView.delegate = self
        }
        if UIDevice.current.userInterfaceIdiom == .pad  {
            ////            leftSidesWidth.constant = view.frame.width*0.6
            textView.font = textView.font!.withSize(view.frame.height*0.02)
            bottomPrivacyTopCons.constant = 70
            scrollHeihgt.constant = view.frame.height*1.5
            textviewHeight.constant = 600
            firstLineHeight.constant = 130
            secondLineHeight.constant = 130
            thirdLineHeight.constant = 130
            //            bottomTopConstant.constant = 30
            //            midTopConstant.constant = 30
            privacyLabel.font = privacyLabel.font.withSize(view.frame.height*0.018)
            termsLabel.font = termsLabel.font.withSize(view.frame.height*0.018)
            getProWidth.constant = view.frame.height*0.13
            getProHeight.constant = view.frame.height*0.13
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
    func setupUi(){
        leftRadius(view: topLeftView)
        leftRadius(view: midLeftView)
        leftRadius(view: bottomLeftView)
        rightRadius(view: topRightView)
        rightRadius(view: midRightView)
        rightRadius(view: bottomRightView)
        
        privacyLabel.isUserInteractionEnabled = true
        privacyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(privacyTapped)))
        termsLabel.isUserInteractionEnabled = true
        termsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsTapped)))
        topLeftView.isUserInteractionEnabled = true
        topLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topLeftViewTapped)))
        topRightView.isUserInteractionEnabled = true
        topRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topRightViewTapped)))
        midLeftView.isUserInteractionEnabled = true
        midLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(midLeftViewTapped)))
        midRightView.isUserInteractionEnabled = true
        midRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topRightViewTapped)))
        bottomLeftView.isUserInteractionEnabled = true
        bottomLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomLeftViewTapped)))
        bottomRightView.isUserInteractionEnabled = true
        bottomRightView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomRightViewTapped)))
        privacyyLabel.isUserInteractionEnabled = true
        privacyyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(privacyyAltTapped)))
        babyImage.clipsToBounds = true
        babyImage.layer.cornerRadius = 20
        babyImage.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.overrideUserInterfaceStyle = .light
        privacyLabel.font = privacyLabel.font.withSize(view.frame.height*0.022)
        privacyyLabel.font = privacyyLabel.font.withSize(view.frame.height*0.022)
        termsLabel.font = termsLabel.font.withSize(view.frame.height*0.022)
        unlockLabel.font = unlockLabel.font.withSize(view.frame.height*0.022)
        removeLabel.font = removeLabel.font.withSize(view.frame.height*0.022)
        yearLabel.font = yearLabel.font.withSize(view.frame.height*0.022)
        yearPriceLabel.font = yearPriceLabel.font.withSize(view.frame.height*0.022)
        mounthLabel.font = mounthLabel.font.withSize(view.frame.height*0.022)
        mountPriceLabel.font = mountPriceLabel.font.withSize(view.frame.height*0.022)
        lifeTimeLabel.font = lifeTimeLabel.font.withSize(view.frame.height*0.022)
        lfitimePriceLabel.font = lfitimePriceLabel.font.withSize(view.frame.height*0.022)
        restoreWidth.constant = view.frame.width*0.35
        if UIDevice.current.userInterfaceIdiom == .pad  {
            babyImageHeight.constant = 400
        }
        
    }
    func leftRadius(view : UIView){
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    func rightRadius(view : UIView){
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    @objc func privacyyAltTapped (){
        guard let url = URL(string: "https://termify.io/privacy-policy/1660214687") else { return }
        UIApplication.shared.open(url)
        
    }
    
    @objc func privacyTapped (){
        guard let url = URL(string: "https://termify.io/eula/1660213690") else { return }
        UIApplication.shared.open(url)
        
    }
    @objc func termsTapped (){
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    @objc func topLeftViewTapped (){
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.mounthlyPro.rawValue]
            print(set)
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
    }
    @objc func topRightViewTapped (){
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.mounthlyPro.rawValue]
            print(set)
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
    }
    @objc func midLeftViewTapped (){
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.yearlyPro.rawValue]
            print(set)
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
    }
    @objc func midRightViewTapped (){
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.yearlyPro.rawValue]
            print(set)
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
    }
    @objc func bottomLeftViewTapped (){
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.lifeTimePro.rawValue]
            print(set)
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
    }
    @IBAction func closeTappedd(_ sender: UIButton) {
        if Utils.isRemoveFirstClose == true{
            Utils.isRemoveFirstClose = false
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            destinationVC.modalPresentationStyle = .fullScreen
            
            self.present(destinationVC, animated: true, completion: nil)
        }else{
            if Utils.addTimer <= 0{
                if interstitial != nil  {
                    GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])
                    interstitial?.present(fromRootViewController: self)
                    isAd = true
                } else {
                    print("Ad wasn't ready")
                    
                    if isComeFromPlayer == "sound" || isComeFromPlayer == "music"  {
                        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                        destinationVC.modalPresentationStyle = .fullScreen
                        destinationVC.vcType = isComeFromPlayer
                        self.present(destinationVC, animated: true, completion: nil)
                        
                    }else if isComeFromPlayer == "settings"{
                        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                        destinationVC.modalPresentationStyle = .fullScreen
                        self.present(destinationVC, animated: true, completion: nil)
                    }else{
                        
                        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        destinationVC.modalPresentationStyle = .fullScreen
                        
                        self.present(destinationVC, animated: true, completion: nil)
                    }
                }
            }else{
                if isComeFromPlayer == "sound" || isComeFromPlayer == "music" {
                    let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                    destinationVC.modalPresentationStyle = .fullScreen
                    destinationVC.vcType = isComeFromPlayer
                    self.present(destinationVC, animated: true, completion: nil)
                }else if isComeFromPlayer == "settings"{
                    let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                    destinationVC.modalPresentationStyle = .fullScreen
                    self.present(destinationVC, animated: true, completion: nil)
                }else{
                    let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    destinationVC.modalPresentationStyle = .fullScreen
                    
                    self.present(destinationVC, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func bottomRightViewTapped (){
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.lifeTimePro.rawValue]
            print(set)
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
        }
        
        
    }
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



extension RemoveViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products.first)
        if let oproduct = response.products.first{
            
            self.purchase(aproduct: oproduct)
        }
    }
    
    func purchase ( aproduct: SKProduct){
        let payment = SKPayment(product: aproduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState{
            case .purchasing:
                print("pur")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                Utils.saveLocal(array: "premium", key: "purchase")
                Utils.isPremium = "premium"
                let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
                
                Utils.saveLocal(array:  "\(nextMonth)", key: "nextMounth")
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                destinationVC.modalPresentationStyle = .fullScreen
                self.present(destinationVC, animated: true, completion: nil)
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                Utils.saveLocal(array: "notPremium", key: "purchase")
                
            case .restored:
                Utils.saveLocal(array: "premium", key: "purchase")
                Utils.isPremium = "premium"
                
                print("restore")
            case .deferred:
                Utils.saveLocal(array: "NotPremium", key: "purchase")
                
                print("deffered")
            default: break
            }
            
        }
    }
    
    func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: Set(Products.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
    }
    
}
extension RemoveViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
