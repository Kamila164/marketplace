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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var serviceArray: [Service] = []
    var categoryArray: [Category] = []
    var productArray: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureServiceCV()
        configureCategoryCV()
        configureProductTV()
        
        fetchProduct()
        fetchCategory()
        fetchService()
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
    
    private func fetchProduct() {
        NetworkLayer.shared.fetchProduct { result in
            switch result {
            case .success(let model):
                self.productArray = model
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .failure(let error):
                self.showAlert(error)
            }
        }
    }
    private func searchProduct(by word: String) {
        NetworkLayer.shared.searchProduct(by: word) { result in
            switch result {
            case .success(let model):
                self.productArray = model
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .failure(let error):
                self.showAlert(error)
            }
        }
    }
    
    private func fetchCategory() {
        do {
            categoryArray = try NetworkLayer.shared.fetchCategory()
            categoryCollectionView.reloadData()
        } catch {
            showAlert(error)
        }
    }
    
    private func fetchService() {
        do {
            serviceArray = try NetworkLayer.shared.fetchService()
            serviceCollectionView.reloadData()
        } catch {
            showAlert(error)
        }
    }
    
    private func showAlert(_ error: Error) {
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
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.reuseId,
            for: indexPath
        ) as! ProductTableViewCell
        let model = productArray[indexPath.row]
        cell.delegate = self
        cell.display(item: model)
        
        return cell
    }
}

extension ViewController: ProductDelegate {
    func didSelectProduct(item: Product) {
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "product_vc") as! ProductViewController
        secondVC.product = item
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchProduct(by: searchText)
    }
}
