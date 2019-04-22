//
//  FeedViewController.swift
//  FindMyTruck
//
//  Created by chino abatol on 4/22/19.
//  Copyright © 2019 chino abatol. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewCell {

    @IBOutlet weak var truckName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
