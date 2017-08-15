//
//  MainVC.swift
//  AtheletsInfo
//
//  Created by Vortex on 8/14/17.
//  Copyright © 2017 Apptcom. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var athletesTableView: UITableView!
    let athlete = Athlete()
    var athletes = [Athlete]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        athletesTableView.dataSource = self
        athletesTableView.delegate = self
        registerNibs()
        athlete.delegate = self
        athlete.downloadAthletes()
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = UIColor.red
        athletesTableView.refreshControl = refreshControl
    }
    
    func registerNibs() {
        let cellNib = UINib(nibName: "AthletesCell", bundle: nil)
        athletesTableView.register(cellNib, forCellReuseIdentifier: "AthletesCell")
    }
    
    func refreshTableView() {
        athlete.downloadAthletes()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let detailVC = segue.destination as? DetailsVC {
                detailVC.athlete = sender as! Athlete
            }
        }
    }
    
}

extension MainVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AthletesCell", for: indexPath) as! AthletesCell
        cell.configure(athletes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }
    
}

extension MainVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: athletes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}

extension MainVC : AthleteDelegate {
    func onDownloadStart() {
        LoadingIndicatorView.show("Loading athletes data..")
    }
    
    func onDownloadSuccess(_ athletes: [Athlete]) {
        self.athletes = athletes
        athletesTableView.reloadData()
        LoadingIndicatorView.hide()
    }
    
    func onRequestFailure(_ error: NSError) {
        let retryButton = createAction(title: "Retry", style: .default, handler: { _ in
            self.athlete.downloadAthletes()
        })
        let cancelButton = createAction(title: "Cancel", style: .default)
        showAlert(alertTitle: "Request Failure", alertMsg: error.localizedDescription, actions: [retryButton,cancelButton])
        LoadingIndicatorView.hide()
    }
    
    func onUnexpectedResponse(_ error: String) {
        let retryButton = createAction(title: "Retry", style: .default, handler: { _ in
            self.athlete.downloadAthletes()
        })
        let cancelButton = createAction(title: "Cancel", style: .default)
        showAlert(alertTitle: "Data Download Failure", alertMsg: error, actions: [retryButton,cancelButton])
        LoadingIndicatorView.hide()
    }
}
