//
//  UIImageViewExtensions.swift
//  AtheletsInfo
//
//  Created by Vortex on 8/14/17.
//  Copyright © 2017 Apptcom. All rights reserved.
//

import UIKit
private var roundedCorners : Bool = false
extension UIImageView {
    var hasRoundedCorners : Bool {
        get {
            return roundedCorners
        } set {
            roundedCorners = newValue
            if(roundedCorners)
            {
                self.layer.borderWidth = 3
                self.layer.borderColor = UIColor.white.cgColor
                self.layer.cornerRadius = self.frame.height / 2
                self.layer.masksToBounds = true
            } else {
                self.layer.borderWidth = 0
                self.layer.cornerRadius = 0
                self.layer.masksToBounds = false
            }
        }
    }
}
