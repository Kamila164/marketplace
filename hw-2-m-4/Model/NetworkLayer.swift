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
    
    private var baseURL = URL(string: "https://dummyjson.com/products")!
    
    func fetchProduct(completion: @escaping (Result<[Product], Error>) -> Void) {
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                let model: Products = self.decode(with: data)
                completion(.success(model.products))
            }
        }
        .resume()
    }
    
    func searchProduct(by word: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("search")
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [.init(name: "q", value: word)]
        
        if let url = urlComponents?.url {
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    let model: Products = self.decode(with: data)
                    completion(.success(model.products))
                }
            }
            .resume()
        }
    }
    
    func fetchCategory() throws -> [Category] {
        let data = Data(categoryJSON.utf8)
        return try decode(with: data)
    }
    
    func fetchService() throws -> [Service] {
        let data = Data(serviceJSON.utf8)
        return try decode(with: data)
    }
    
    func decode<T: Decodable>(with data: Data) -> T {
       try! JSONDecoder().decode(T.self, from: data)
    }
}
