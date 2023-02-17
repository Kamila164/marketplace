//
//  Product.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import Foundation

let productJSON = """
[
{
    "productImage": "burger",
    "productName": "Burger Craze",
    "productWorkingHouse": "Open",
    "productRating": "4.6 (601)",
    "productCountry": "American",
    "productType": "Burgers",
    "productDeliveryType": "Delivery: FREE",
    "productDeliveryPrice": "Minimum: $10",
    "productDistance": "1.5 km away",
    "timeOfDelivery": "15-20 min"
},
{
    "productImage": "pizza",
    "productName": "Vegetarian Pizza",
    "productWorkingHouse": "Open",
    "productRating": "4.6 (601)",
    "productCountry": "Italian",
    "productType": "Pizza",
    "productDeliveryType": "Delivery: FREE",
    "productDeliveryPrice": "Minimum: $10",
    "productDistance": "1.8 km away",
    "timeOfDelivery": "10-15 min"
}
]
"""

struct Product: Decodable {
    var productImage: String
    var productName: String
    var productWorkingHouse: String
    var productRating: String
    var productCountry: String
    var productType: String
    var productDeliveryType: String
    var productDeliveryPrice: String
    var productDistance: String
    var timeOfDelivery: String
}
