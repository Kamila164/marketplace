//
//  CategoryCell.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static var reuseId = String(describing: CategoryCell.self)

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func display(item: Category) {
        categoryImageView.image = UIImage(named: item.categoryImage)
        categoryLabel.text = item.CategoryTitle
    }
}
