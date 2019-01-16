//
//  WorkoutTableViewCell.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/17/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var length: UILabel!
    
    @IBOutlet weak var reps: UILabel!
    
    @IBOutlet weak var weight: UILabel!
    
    @IBOutlet weak var timeStack: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
