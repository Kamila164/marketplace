//
//  ViewController.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    let serviceArray: [Service] = [
        Service(serviceTitle: "Delivery"),
        Service(serviceTitle: "Pickup"),
        Service(serviceTitle: "Catering"),
        Service(serviceTitle: "Curbside")]
    
    let categoryArray: [Category] = [
        Category(categoryImage: "takeawaysImage", CategoryTitle: "Takeaways"),
        Category(categoryImage: "groceryImage", CategoryTitle: "Grocery"),
        Category(categoryImage: "convenienceImage", CategoryTitle: "Convenience"),
        Category(categoryImage: "pharmacyImage", CategoryTitle: "Pharmacy")]
    
    let productArray: [Product] = [
        Product(
            productImage: "burger",
            productName: "Burger Craze",
            productWorkingHouse: "Open",
            productRating: "4.6 (601)",
            productCountry: "American",
            productType: "Burgers",
            productDeliveryType: "Delivery: FREE",
            productDeliveryPrice: "Minimum: $10",
            productDistance: "1.5 km away",
            timeOfDelivery: "15-20 min"
        ),
        Product(
            productImage: "pizza",
            productName: "Vegetarian Pizza",
            productWorkingHouse: "Open",
            productRating: "4.6 (601)",
            productCountry: "Italian",
            productType: "Pizza",
            productDeliveryType: "Delivery: FREE",
            productDeliveryPrice: "Minimum: $10",
            productDistance: "1.8 km away",
            timeOfDelivery: "10-15 min"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureServiceCV()
        configureCategoryCV()
        configureProductTV()
    }
    
    private func configureServiceCV() {
        serviceCollectionView.dataSource = self
        serviceCollectionView.delegate = self
        serviceCollectionView.register(
            UINib(
                nibName: String(describing: ServiceCell.self),
                bundle: nil
            ),
            forCellWithReuseIdentifier: ServiceCell.reuseId
        )
    }
    
    private func configureCategoryCV() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(
            UINib(
                nibName: String(describing: CategoryCell.self),
                bundle: nil
            ),
            forCellWithReuseIdentifier: CategoryCell.reuseId
        )
    }
    
    private func configureProductTV() {
        productTableView.dataSource = self
        productTableView.register(
            UINib(
                nibName: String(describing: ProductTableViewCell.self),
                bundle: nil
            ),
            forCellReuseIdentifier: ProductTableViewCell.reuseId
        )
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == serviceCollectionView {
            return serviceArray.count
        } else {
            return categoryArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == serviceCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ServiceCell.reuseId,
                for: indexPath
            ) as! ServiceCell
            let model = serviceArray[indexPath.row]
            cell.display(item: model)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.reuseId,
                for: indexPath
            ) as! CategoryCell
            let model = categoryArray[indexPath.row]
            cell.display(item: model)
            
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == serviceCollectionView {
            return CGSize(width: 100, height: 36)
        } else {
            return CGSize(width: 80, height: 110)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.reuseId,
            for: indexPath
        ) as! ProductTableViewCell
        let model = productArray[indexPath.row]
        cell.display(item: model)
        
        return cell
    }
}
