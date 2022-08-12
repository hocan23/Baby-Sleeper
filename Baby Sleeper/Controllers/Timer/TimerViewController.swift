//
//  TimerViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 8/1/22.
//

import UIKit
protocol TimerStartProtocol{
    func timerStart(time:Int)
}
class TimerViewController: UIViewController {
    
    @IBOutlet weak var pickerTime: UIPickerView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    var delegate : TimerStartProtocol?
    var timerss : Timer = Timer()
    var timerCount:Int = 0
    
    @IBOutlet weak var remainTimeLabel: UILabel!
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
        remainTimeLabel.isHidden = true
        view.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timerStart(time: timerCount)
        if Utils.timerRemainCount != 0{
            saveBtn.setTitle("Stop", for: .normal)
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
    override func viewDidDisappear(_ animated: Bool) {
        Utils.timerCount = time ?? 0
    }
   
    func timerStart(time: Int) {
        timerCount = time
        timerss.invalidate()
        if Utils.timerRemainCount == 0{
            //            timerLabel.isHidden=true
        }else{
            timerss = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounterr), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounterr(){
        self.timerCount -= 1
        if self.timerCount == 0 {
            print("Go!")
            print(Utils.listMusic)
            GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])
            self.remainTimeLabel.isHidden = true
            Utils.listMusic = nil
            Utils.timerRemainCount = 0
            timerss.invalidate()
            
        } else {
            self.remainTimeLabel.isHidden = false
            let watch = StopWatch(totalSeconds: self.timerCount)
            print(watch.simpleTimeString)
            let currentTime = watch.simpleTimeString
            self.remainTimeLabel.text = "\(currentTime)"
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        saveBtn.zoomIn()
        time = (minutes+hour*60)*60
        Utils.timerRemainCount = time ?? 0
        
        if Utils.timerRemainCount < 2{
            delegate?.timerStart(time: 0)
            timerss.invalidate()
            remainTimeLabel.isHidden = true
            saveBtn.setTitle("Start", for: .normal)
        }else{
            delegate?.timerStart(time: time ?? 0)
            dismiss(animated: true)
        }
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        exitBtn.zoomIn()
        dismiss(animated: true)
    }
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
