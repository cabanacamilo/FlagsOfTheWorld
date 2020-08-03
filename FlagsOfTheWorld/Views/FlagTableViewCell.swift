//
//  FlagTableViewCell.swift
//  FlagsOfTheWorld
//
//  Created by Camilo Cabana on 3/08/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class FlagTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    func configure(flag: Flag) {
        flagLabel.text = flag.flag
        countryLabel.text = flag.country
        regionLabel.text = flag.region
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
