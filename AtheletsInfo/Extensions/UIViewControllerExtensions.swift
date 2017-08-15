//
//  UIViewControllerExtensions.swift
//  AtheletsInfo
//
//  Created by Vortex on 8/15/17.
//  Copyright © 2017 Apptcom. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(alertTitle: String, alertMsg: String, actions : [UIAlertAction] , action: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func createAction(title : String, style : UIAlertActionStyle, handler : ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }

}
