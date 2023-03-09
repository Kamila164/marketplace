//
//  Alert.swift
//  hw-2-m-4
//
//  Created by Kamila on 23/2/23.
//

import UIKit

extension UIViewController {
     func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: "\(error.localizedDescription)",
            preferredStyle: .alert
        )
        let acceptAction = UIAlertAction(
            title: "OK",
            style: .destructive
        )
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
     func showSuccess(_ message: String) {
        let alert = UIAlertController(
            title: "Success",
            message: message,
            preferredStyle: .alert
        )
        let acceptAction = UIAlertAction(
            title: "OK",
            style: .default
        )
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
}
