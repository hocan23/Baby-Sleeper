//
//  SettingsViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/29/22.
//

import UIKit
import StoreKit
import GoogleMobileAds



class SettingsViewController: UIViewController{
    
    @IBOutlet weak var tableTopCons: NSLayoutConstraint!
    @IBOutlet weak var getProImage: UIImageView!
    @IBOutlet weak var homeView: UIImageView!
    @IBOutlet weak var removeBottomCons: NSLayoutConstraint!
    @IBOutlet weak var getProLeftCons: NSLayoutConstraint!
    @IBOutlet weak var tableTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var getProheightCons: NSLayoutConstraint!
    @IBOutlet weak var getProwidthcons: NSLayoutConstraint!
    @IBOutlet weak var unlockBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var getProImageHighconstant: NSLayoutConstraint!
    @IBOutlet weak var removeLabell: UILabel!
    @IBOutlet weak var removeAdView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var unlockLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabletopunlockCons: NSLayoutConstraint!
    
    var headers = ["Share App","Other Apps",  "Rate App","Restore Purchase","Terms of Pro Services","Privacy Policy"]
    var models = [SKProduct]()
    enum Products : String,CaseIterable{
        case removeAds = "com.SIX11.learnABC.removeAds"
    }
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    var isAd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUi()
        SKPaymentQueue.default().add(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true {
            Utils.addTimer = 40
            self.dismiss(animated: true)
        }
        
        if Utils.isPremium == "premium"{
            getProImage.isUserInteractionEnabled = false
            removeAdView.isHidden = true
            tableTopCons.constant = 30
            removeLabell.isHidden = true
            getProImage.isHidden = true
            unlockLabel.isHidden = true
        }else{
            createAdd()
            bannerView = GADBannerView(adSize: GADAdSizeBanner)
            bannerView.adUnitID = Utils.bannerId
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            bannerView.delegate = self
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .lightContent
        } else {
            return .default
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
            
        }
    }
    
    @objc func proImageTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "RemoveViewController") as! RemoveViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    func setupUi(){
        view.overrideUserInterfaceStyle = .light
        tableView.isScrollEnabled = false
        removeAdView.layer.cornerRadius = 20
        getProImage.layer.cornerRadius = 20
        getProImage.isUserInteractionEnabled = true
        getProImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(proImageTapped)))
        if UIDevice.current.userInterfaceIdiom == .pad  {
            getProImageHighconstant.constant = 250
            tableTopConstraint.constant = 290
        }
        unlockBottomAnchor.constant = view.frame.height * 0.035
        tableView.layer.cornerRadius = 10
        unlockLabel.font = unlockLabel.font.withSize(view.frame.height*0.017)
        removeLabell.font = removeLabell.font.withSize(view.frame.height*0.017)
        getProwidthcons.constant = view.frame.height*0.1
        getProheightCons.constant = view.frame.height*0.1
        if UIDevice.current.userInterfaceIdiom == .pad  {
            removeBottomCons.constant = 30
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        homeButton.zoomIn()
        if Utils.addTimer <= 0{
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
                isAd = true
            } else {
                print("Ad wasn't ready")
                self.dismiss(animated: true)
            }
        }else{
            self.dismiss(animated: true)
        }
        
    }
    
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        headers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
        cell.tableLabel.text = headers[indexPath.row]
        if cell.isSelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        cell.selectionStyle = .default;
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        switch indexPath.row{
        case 0 :
            if let url = URL(string: "https://apps.apple.com/us/developer/mehmet-rasit-arisu/id1346135076?see-all=i-phonei-pad-apps") {
                UIApplication.shared.open(url)
            }
        case 1:
            if let url = URL(string: "https://apps.apple.com/tr/developer/mehmet-rasit-arisu/id1346135076?see-all=i-phonei-pad-apps") {
                UIApplication.shared.open(url)
            }
        case 2:
            if let url = URL(string: "https://apps.apple.com/us/app/baby-sleep-sound-white-noise/id1638514663") {
                UIApplication.shared.open(url)
            }
        case 3:
            SKPaymentQueue.default().restoreCompletedTransactions()
            
        case 4:
            if let url = URL(string: "https://termify.io/eula/1660213690") {
                UIApplication.shared.open(url)
            }
        case 5:
            if let url = URL(string: "https://termify.io/privacy-policy/1660214687") {
                UIApplication.shared.open(url)
            }
        default: break
        }
    }
}

extension SettingsViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
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
                
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .restored:
                print("restore")
                Utils.saveLocal(array: "premium", key: "purchase")
                Utils.isPremium = "premium"
            case .deferred:
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

extension SettingsViewController: GADBannerViewDelegate, GADFullScreenContentDelegate{
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
