//
//  AthleteDelegate.swift
//  AtheletsInfo
//
//  Created by Vortex on 8/14/17.
//  Copyright © 2017 Apptcom. All rights reserved.
//

import Foundation

protocol AthleteDelegate : class {
    func onDownloadStart()
    func onDownloadSuccess(_ athletes : [Athlete])
    func onRequestFailure(_ error : NSError)
    func onUnexpectedResponse(_ error : String)
}
