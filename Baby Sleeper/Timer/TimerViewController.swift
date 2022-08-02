//
//  TimerViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 8/1/22.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var pickerTime: UIPickerView!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    var hour:Int = 0
    var minutes:Int = 0
    var time:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTime.delegate = self
        pickerTime.dataSource = self
        pickerTime.setValue(UIColor.white, forKey: "textColor")
        saveBtn.layer.cornerRadius = 20
        exitBtn.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
         time = (minutes+hour*60)*60
        Timer.scheduledTimer(withTimeInterval: TimeInterval(time!), repeats: false) { (t) in
            GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])

           print("time")
        }
//        var timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)

    }
//    @objc func update() {
//        if(time! > 0) {
//            time!-=1
//            print("\(time)")
//        }else{
//
//        }
//    }

    @IBAction func exitTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TimerViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return 60
        case 1:
            return 24

        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            return "\(row) Hour"
            
        case 1:
            return "\(row) Minute"
        
        default:
            return ""
        }
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        
        default:
            break;
        }
    }
}
