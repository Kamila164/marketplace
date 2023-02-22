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
    
    var product: Product?

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
        NetworkLayer.shared.addNewProduct(with: product) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.showSuccess("Succesful")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
        }
    }
    
    private func showError(_ message: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: message.localizedDescription,
            preferredStyle: .alert
        )
        let acceptAction = UIAlertAction(
            title: "OK",
            style: .cancel
        )
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    private func showSuccess(_ message: String) {
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

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}
