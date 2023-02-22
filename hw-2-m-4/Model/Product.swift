//
//  Product.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    var id: Int
    var thumbnail: String
    var title: String
    var discountPercentage: Double
    var rating: Double
    var brand: String
    var description: String
    var category: String
    var stock: Int
    var price: Int
}
