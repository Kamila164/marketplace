//
//  ProductViewController.swift
//  hw-2-m-4
//
//  Created by Kamila on 17/2/23.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureUI()
    }
//
//    private func configureUI() {
//        guard let product = product else {
//            return
//        }
//        imageView.image = UIImage(named: product.thumbnail)
//    }
}
