//
//  AthletesCell.swift
//  AtheletsInfo
//
//  Created by Vortex on 8/14/17.
//  Copyright © 2017 Apptcom. All rights reserved.
//

import UIKit

class AthletesCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var athleteImage: UIImageView!
    @IBOutlet weak var athleteName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.isMaterialDesign = true
        athleteImage.hasRoundedCorners = true
        self.selectionStyle = .none
    }
    
    func configure(_ athlete : Athlete) {
        athleteName.text = athlete._name
        athleteImage.image = athlete._image
    }
    
}
