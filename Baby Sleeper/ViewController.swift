//
//  ViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/29/22.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        // Do any additional setup after loading the view.
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

        topLeftLabel.font = UIFont(name: "Cera Pro Medium", size: 50)
        topRightLabel.font = UIFont(name: "Cera Pro Medium", size: view.frame.height*0.025)
        bottomLeftLabel.font = UIFont(name: "Cera Pro Medium", size: view.frame.height*0.025)
        bottomRightLabel.font = UIFont(name: "Cera Pro Medium", size: view.frame.height*0.025)
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

        }

    }
    func bottomRadius(view : UIView){
        view.clipsToBounds = true
            view.layer.cornerRadius = 20
        view.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    @objc func topLeftViewTapped (){
        
    }
    @objc func topRightViewTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
    @objc func bottomLeftViewTapped (){
        
    }
    @objc func bottomRightViewTapped (){
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        destinationVC.modalPresentationStyle = .fullScreen
        self.present(destinationVC, animated: true, completion: nil)
    }
}

