//
//  Service.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import Foundation

let serviceJSON = """
[
{
    "serviceTitle": "Delivery"
},
{
    "serviceTitle": "Pickup"
},
{
    "serviceTitle": "Catering"
},
{
    "serviceTitle": "Curbside"
}
]
"""

struct Service: Decodable {
    var serviceTitle: String
}
