//
//  MixPlayerTableViewCell.swift
//  Baby Sleeper
//
//  Created by Hasan Onur Can on 8/3/22.
//

import UIKit

class MixPlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBack.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
