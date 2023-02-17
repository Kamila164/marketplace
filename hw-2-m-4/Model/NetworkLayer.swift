//
//  NetworkLayer.swift
//  hw-2-m-4
//
//  Created by Kamila on 17/2/23.
//

import Foundation

final class NetworkLayer {
    static let shared = NetworkLayer()
    
    private init() {}
    
    func fetchProduct() throws -> [Product] {
        let data = Data(productJSON.utf8)
        return try decode(data)
    }
    
    func fetchCategory() throws -> [Category] {
        let data = Data(categoryJSON.utf8)
        return try decode(data)
    }
    
    func fetchService() throws -> [Service] {
        let data = Data(serviceJSON.utf8)
        return try decode(data)
    }
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
