//
//  ListCell.swift
//  FindMyTruck
//
//  Created by chino abatol on 4/28/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var cellDistance: UILabel!
    @IBOutlet weak var cellTruckname: UILabel!
    @IBOutlet weak var celladdress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
