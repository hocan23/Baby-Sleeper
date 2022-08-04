//
//  RemoveViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 8/1/22.
//

import UIKit

class RemoveViewController: UIViewController {

    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var midRightView: UIView!
    @IBOutlet weak var midLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var topLeftView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

setupUi()
        // Do any additional setup after loading the view.
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
       
    }
    @objc func termsTapped (){
       
    }
    @objc func topLeftViewTapped (){
       
    }
    @objc func topRightViewTapped (){
       
    }
    @objc func midLeftViewTapped (){
       
    }
    @objc func midRightViewTapped (){
       
    }
    @objc func bottomLeftViewTapped (){
       
    }
    @objc func bottomRightViewTapped (){
       
    }
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func restoreBtnTapped(_ sender: Any) {
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
