//
//  StationCell.swift
//  TagTheBusSwift
//
//  Created by cyrine on 27/01/2017.
//  Copyright © 2017 cyrine. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {

   
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
