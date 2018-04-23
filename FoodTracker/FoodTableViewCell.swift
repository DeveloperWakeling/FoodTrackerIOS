//
//  FoodTableViewCell.swift
//  FoodTracker
//
//  Created by Michael Wakeling on 4/22/18.
//  Copyright © 2018 Michael Wakeling. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
