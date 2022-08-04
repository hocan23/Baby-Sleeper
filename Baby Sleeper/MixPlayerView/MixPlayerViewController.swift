//
//  MixPlayerViewController.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 8/3/22.
//

import UIKit

class MixPlayerViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    var playlist : [[BabyAudio]] = []
    var playlistlocale : [String]?
    var descriptionn : String?
    var beforeSelectNumber : Int?
    var selectNumber : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        playlistlocale = Utils.readLocalList(key: "list")
//        print(Utils.readLocale(key: inputName ?? ""))
        if let playlistlocale = playlistlocale {
            for a in playlistlocale{
                var b = Utils.readLocale(key: a )
                playlist.append(b)

            }
        
        print(playlist)
        }
        view.overrideUserInterfaceStyle = .light

//        playlist = Utils.readLocale(key: inputName ?? ""
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Utils.listMusic = playlist[selectNumber ?? 0]

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
extension MixPlayerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlistlocale?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MixCell", for: indexPath) as! MixPlayerTableViewCell
        cell.headerLabel.text = playlistlocale![indexPath.row]
        var audioNames = ""
        var b = 0
        for a in playlist[indexPath.row]{
            if b == 0{
                audioNames+=a.musicName
                b+=1
            }else{
                audioNames += ", \(a.musicName)"

            }
        }
        if indexPath.row == selectNumber{
            cell.viewBack.backgroundColor = UIColor(red: 140/255, green: 1, blue: 227/255, alpha: 0.5)
        }else{
            cell.viewBack.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        }
        if beforeSelectNumber == nil{
            cell.viewBack.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)

        }
       
        cell.bottomLabel.text = audioNames
        cell.selectionStyle = .default;
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GSAudio.sharedInstance.stopSounds(soundFiles: Utils.listMusic ?? [])
        selectNumber = indexPath.row
        tableView.reloadData()
        GSAudio.sharedInstance.stopSounds(soundFiles: playlist[beforeSelectNumber ?? 0])
        print(beforeSelectNumber)
        print(selectNumber)
        if beforeSelectNumber != selectNumber{
        for a in playlist[indexPath.row]{
            GSAudio.sharedInstance.playSound(soundFileName: a.musicName, volume: a.musicVolume)

        }
        Utils.setToMusicList(type: playlist[indexPath.row])
        print(Utils.listMusic)
            beforeSelectNumber = indexPath.row

        }else{
            beforeSelectNumber = nil
            tableView.reloadData()
        }

        
    }
    
    
}