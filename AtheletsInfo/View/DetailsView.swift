//
//  DetailsView.swift
//  AtheletsInfo
//
//  Created by Vortex on 8/15/17.
//  Copyright © 2017 Apptcom. All rights reserved.
//

import UIKit

class DetailsView : UIView {
    @IBOutlet weak var athleteImage: UIImageView!
    @IBOutlet weak var athleteName: UILabel!
    @IBOutlet weak var athleteBrief: UITextView!
    
    override func awakeFromNib() {
        athleteImage.hasRoundedCorners = true
    }
    
    func configure(_ athlete : Athlete) {
        athleteImage.image = athlete._image
        athleteName.text = athlete._name
        athleteBrief.text = athlete._brief
        athleteBrief.setContentOffset(.zero, animated: false)
    }
    
    
    
}
