//
//  BabyTableViewCell.swift
//  babyDOApp
//
//  Created by Tatiane Ferreira on 2017-03-24.
//  Copyright © 2017 Tatiane Ferreira. All rights reserved.
//

import UIKit

class BabyTableViewCell: UITableViewCell {
    

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var babyImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        babyImg.layer.cornerRadius = babyImg.frame.width / 2
        babyImg.layer.masksToBounds = true

        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
