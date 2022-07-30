//
//  MixesTableViewCell.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 7/30/22.
//

import UIKit

class MixesTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTxt: UILabel!
    
    @IBOutlet weak var delete: UIImageView!
    @IBOutlet weak var slider: UISlider!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
