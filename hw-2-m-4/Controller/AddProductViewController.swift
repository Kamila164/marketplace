//
//  AddProductViewController.swift
//  hw-2-m-4
//
//  Created by Kamila on 20/2/23.
//

import UIKit

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addProduct() {
        guard
            let name = nameTextField.text, name.isNotEmpty,
            let price = priceTextField.text, price.isNotEmpty,
            let desc = descTextField.text, desc.isNotEmpty,
            let category = categoryTextField.text, category.isNotEmpty,
            let brand = brandTextField.text, brand.isNotEmpty else {
            return
        }
        
        let product = Product(
            id: 0,
            thumbnail: "",
            title: name,
            discountPercentage: 0,
            rating: 0,
            brand: brand,
            description: desc,
            category: category,
            stock: 0,
            price: Int(price) ?? 0)

        addNew(product)
    }
    
    private func addNew(_ product: Product) {
        isLoading = true
        Task {
            do {
                let model = try await NetworkLayer.shared.addNewProdduct(with: product)
                isLoading = false
                DispatchQueue.main.async {
                    self.showSuccess("")
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
        }
    }
}

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}
