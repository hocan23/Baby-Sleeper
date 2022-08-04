//
//  MixViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/30/22.
//

import UIKit
import AVFoundation

class MixViewController: UIViewController ,AVAudioPlayerDelegate  {
    var player : AVAudioPlayer?
    var playlistLocale : [String]?
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
        playlistLocale = Utils.readLocalList(key: "list")
        view.overrideUserInterfaceStyle = .light
    }
    func alert (){
        let alertController = UIAlertController(title: "New Folder", message: "name this folder", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Name"
        }


        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            // this code runs when the user hits the "save" button

            let inputName = alertController.textFields![0].text
            self.playlistLocale?.append(inputName ?? "")
            print(self.playlistLocale)
            Utils.saveLocalList(array: self.playlistLocale ?? [], key: "list")
            print(Utils.readLocalList(key: "list"))
            Utils.saveLocal(array: self.playlist ?? [], key: inputName ?? "")
            print(Utils.readLocale(key: inputName ?? ""))

        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        alert()
        print(playlist)
       
    }
    @IBAction func closedTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        print(sender.value)
        playlist?[sender.tag].musicVolume = sender.value
        GSAudio.sharedInstance.stopSound(soundFileName: playlist![sender.tag].musicName)

        playlist?[sender.tag].musicVolume = sender.value
        GSAudio.sharedInstance.playSound(soundFileName:  playlist![sender.tag].musicName,volume:  playlist![sender.tag].musicVolume)

    }
    
}
extension MixViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.count ?? 0    // 2 rows in the cell, for demo purposes
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MixesTableViewCell
        cell.selectionStyle = .none
        cell.labelTxt.text = playlist?[indexPath.row].musicName
        cell.slider.tag = indexPath.row
        cell.slider.setValue(playlist?[indexPath.row].musicVolume ?? 1, animated: true)
//        cell.slider.addTarget(tableView, action: Selector(("sliderChange:")), for: .allTouchEvents)

        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
