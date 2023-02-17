//
//  ProductTableViewCell.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import UIKit

protocol ProductDelegate: AnyObject {
    func didSelectProduct(item: Product)
}

class ProductTableViewCell: UITableViewCell {
    
    static var reuseId = String(describing: ProductTableViewCell.self)
    
    @IBOutlet weak var productImageView: UIImageView! {
        didSet {
            productImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnImage))
            productImageView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productWorkingHouseLabel: UILabel!
    @IBOutlet weak var productRatingLabel: UILabel!
    @IBOutlet weak var productCountryLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productdeliveryType: UILabel!
    @IBOutlet weak var productDeliveryPrice: UILabel!
    @IBOutlet weak var productDistance: UILabel!
    @IBOutlet weak var timeOfDelivery: UILabel!
    
    weak var delegate: ProductDelegate?
    private var product: Product?
    
    func display(item: Product) {
        product = item
        
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
    
    @objc func didTapOnImage() {
        guard let product = product else {
            return
        }
        delegate?.didSelectProduct(item: product)
    }
}
