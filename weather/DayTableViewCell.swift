//
//  DayTableViewCell.swift
//  weather
//
//  Created by Wiem Ben Rim on 6/24/17.
//  Copyright © 2017 WBR. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    @IBOutlet weak var dateAndDay: UILabel!
//    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var temperatre: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var mint: UILabel!
    @IBOutlet weak var maxt: UILabel!
    @IBOutlet weak var nightt: UILabel!
    @IBOutlet weak var evet: UILabel!
    @IBOutlet weak var mornt: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
