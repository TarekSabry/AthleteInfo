//
//  DetailsVC.swift
//  AtheletsInfo
//
//  Created by Vortex on 8/14/17.
//  Copyright © 2017 Apptcom. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    var athlete : Athlete!
    @IBOutlet var detailsView: DetailsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = athlete._name
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailsView.configure(athlete)
    }

}
