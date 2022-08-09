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
    
    @IBOutlet weak var getProWidth: NSLayoutConstraint!
    
    @IBOutlet weak var getProHeight: NSLayoutConstraint!
    
    @IBOutlet weak var babyImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var unlockLabel: UILabel!
    @IBOutlet weak var removeLabel: UILabel!
    @IBOutlet weak var termsWidth: NSLayoutConstraint!
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
    enum Products : String,CaseIterable{
        case mounthlyPro = "com.SIX11.babySlepper1month"
        case lifeTimePro = "com.SIX11.babySleeperLifeTime"
        case yearlyPro = "com.SIX11.babySleeper1year"


    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
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
        print(retDate)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true {
            GSAudio.sharedInstance.playSounds(soundFiles: Utils.listMusic ?? [])

            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            destinationVC.modalPresentationStyle = .overFullScreen
          
            self.present(destinationVC, animated: true, completion: nil)
            
        }
        print(Utils.isPremium )
        if Utils.isPremium == "premium"{
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            destinationVC.modalPresentationStyle = .fullScreen
          
            self.present(destinationVC, animated: true, completion: nil)
        }else{
            createAdd()
            
            bannerView = GADBannerView(adSize: GADAdSizeBanner)
            bannerView.adUnitID = Utils.bannerId
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            bannerView.delegate = self
        }
        if UIDevice.current.userInterfaceIdiom == .pad  {
            leftSidesWidth.constant = view.frame.width*0.6
            firstLineHeight.constant = 130
            secondLineHeight.constant = 130
            thirdLineHeight.constant = 130
            bottomTopConstant.constant = 30
            midTopConstant.constant = 30
            privacyLabel.font = privacyLabel.font.withSize(view.frame.height*0.022)
            termsLabel.font = termsLabel.font.withSize(view.frame.height*0.022)
            getProWidth.constant = view.frame.height*0.13
            getProHeight.constant = view.frame.height*0.13
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
        babyImage.clipsToBounds = true
            babyImage.layer.cornerRadius = 20
        babyImage.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.overrideUserInterfaceStyle = .light
        privacyLabel.font = privacyLabel.font.withSize(view.frame.height*0.022)
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
    @objc func privacyTapped (){
        guard let url = URL(string: "https://sites.google.com/view/baby-sleep-sounds-privacy/home") else { return }
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
    @objc func bottomRightViewTapped (){
        if SKPaymentQueue.canMakePayments(){
            let set :  Set<String> = [Products.lifeTimePro.rawValue]
            print(set)
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            
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
  
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
//        GSAudio.sharedInstance.playSounds(soundFiles: Utils.listMusic ?? [])
        if interstitial != nil  {
           
                GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])

            

            interstitial?.present(fromRootViewController: self)
            isAd = true
        } else {
            print("Ad wasn't ready")
            
            if isComeFromPlayer == "sound" || isComeFromPlayer == "music" {
                let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                destinationVC.modalPresentationStyle = .fullScreen
                destinationVC.vcType = isComeFromPlayer
                self.present(destinationVC, animated: true, completion: nil)
            }
            
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            destinationVC.modalPresentationStyle = .fullScreen
          
            self.present(destinationVC, animated: true, completion: nil)
        }
    }
    
}
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
