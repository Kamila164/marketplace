//
//  ProductTableViewCell.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static var reuseId = String(describing: ProductTableViewCell.self)
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productWorkingHouseLabel: UILabel!
    @IBOutlet weak var productRatingLabel: UILabel!
    @IBOutlet weak var productCountryLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productdeliveryType: UILabel!
    @IBOutlet weak var productDeliveryPrice: UILabel!
    @IBOutlet weak var productDistance: UILabel!
    @IBOutlet weak var timeOfDelivery: UILabel!
    
    func display(item: Product) {
        productImageView.image = UIImage(named: item.productImage)
        productNameLabel.text = item.productName
        productWorkingHouseLabel.text = item.productWorkingHouse
        productRatingLabel.text = item.productRating
        productCountryLabel.text = item.productCountry
        productTypeLabel.text = item.productType
        productdeliveryType.text = item.productDeliveryType
        productDeliveryPrice.text = item.productDeliveryPrice
        productDistance.text = item.productDistance
        timeOfDelivery.text = item.timeOfDelivery
    }
}
