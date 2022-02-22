//
//  SVProgressHUD+MovieDB.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import SVProgressHUD

extension SVProgressHUD {
    
    public static func showDismissableError(message: String) {
        let nc = NotificationCenter.default
        nc.addObserver(
            self, selector: #selector(hudTapped(_:)),
            name: .SVProgressHUDDidReceiveTouchEvent,
            object: nil
        )
        SVProgressHUD.showError(withStatus: "\(message)\n\nTap to Dismiss")
    }
    
    public static func showDismissableInfo(message: String) {
        let nc = NotificationCenter.default
        nc.addObserver(
            self, selector: #selector(hudTapped(_:)),
            name: .SVProgressHUDDidReceiveTouchEvent,
            object: nil
        )
        SVProgressHUD.showInfo(withStatus: "\(message)\n\nTap to Dismiss")
    }
    
    public static func showDismissableSuccess(message: String) {
        let nc = NotificationCenter.default
        nc.addObserver(
            self, selector: #selector(hudTapped(_:)),
            name: .SVProgressHUDDidReceiveTouchEvent,
            object: nil
        )
        SVProgressHUD.showSuccess(withStatus: "\(message)\n\nTap to Dismiss")
    }

    @objc
    private static func hudTapped(_ notification: Notification) {
        SVProgressHUD.dismiss()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
    }
    
}

