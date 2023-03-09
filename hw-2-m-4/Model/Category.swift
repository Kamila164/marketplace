//
//  Category.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import Foundation

let categoryJSON = """
[
{
    "categoryImage": "takeawaysImage",
    "CategoryTitle": "Takeaways"
},
{
    "categoryImage": "groceryImage",
    "CategoryTitle": "Grocery"
},
{
    "categoryImage": "convenienceImage",
    "CategoryTitle": "Convenience"
},
{
    "categoryImage": "pharmacyImage",
    "CategoryTitle": "Pharmacy"
}
]
"""

struct Category: Codable {
    var categoryImage: String
    var CategoryTitle: String
}
