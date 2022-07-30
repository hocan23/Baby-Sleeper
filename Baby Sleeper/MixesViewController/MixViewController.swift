//
//  MixViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/30/22.
//

import UIKit

class MixViewController: UIViewController {
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var table: UITableView!
    var playlist : [BabyAudio]?
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate=self
        table.dataSource = self
        closeButton.layer.cornerRadius = 20
        saveButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveTapped(_ sender: UIButton) {
        
    }
    @IBAction func closedTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
extension MixViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 2    // 2 rows in the cell, for demo purposes
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MixesTableViewCell
        cell.selectionStyle = .none
        cell.labelTxt.text = playlist?[indexPath.row].musicName
        cell.slider.tag = indexPath.row
        cell.slider.setValue(playlist?[indexPath.row].musicVolume ?? 1, animated: true)
        cell.slider.addTarget(tableView, action: Selector(("sliderChange:")), for: .valueChanged)

        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   @objc func sliderChange(sender: UISlider) {
       print("changed")
//            let currentValue = sender.value    // get slider's value
//            let row = sender.tag               // get slider's row in table
//
//            print("Slider in row \(row) has a value of \(currentValue)")
            // example output - Slider in row 1 has a value of 0.601399
        }
}
