//
//  ProductTableViewCell.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

protocol ProductDelegate: AnyObject {
    func didSelectProduct(item: Product)
}

class ProductTableViewCell: UITableViewCell {
    
    static var reuseId = String(describing: ProductTableViewCell.self)
    
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnImage))
            thumbnailImageView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discountPercentageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var delegate: ProductDelegate?
    private var product: Product?
    
    func display(item: Product) {
        product = item
        
        let imgUrl = item.thumbnail
        thumbnailImageView.downloaded(from: imgUrl)
        titleLabel.text = item.title
        discountPercentageLabel.text = "-\(item.discountPercentage)%"
        ratingLabel.text = "\(item.rating)"
        brandLabel.text = item.brand
        descriptionLabel.text = item.description
        categoryLabel.text = "#\(item.category)"
        stockLabel.text = "\(item.stock)"
        priceLabel.text = "\(item.price)$"
    }
    
    @objc func didTapOnImage() {
        guard let product = product else {
            return
        }
        delegate?.didSelectProduct(item: product)
    }
}
