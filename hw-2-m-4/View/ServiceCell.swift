//
//  ServiceCell.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import UIKit

class ServiceCell: UICollectionViewCell {
    
    static var reuseId = String(describing: ServiceCell.self)
    
    @IBOutlet weak var serviceLabel: UILabel!

    func display(item: Service) {
        serviceLabel.text = item.serviceTitle
    }
    
}
