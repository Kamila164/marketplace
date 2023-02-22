//
//  NetworkLayer.swift
//  hw-2-m-4
//
//  Created by Kamila on 17/2/23.
//

import Foundation

enum HTTPRequest: String {
    case GET, POST, PUT, DELETE
}

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
    
    func addNewProduct(with model: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("add")
        var request = URLRequest(url: url)
        request.httpMethod = HTTPRequest.POST.rawValue
        request.httpBody = encode(with: model)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if data != nil {
                completion(.success(()))
            }
        }
        .resume()
    }
    
    func deleteProduct(with id: Int, completion: @escaping(Result<Void, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HTTPRequest.DELETE.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if data != nil {
                completion(.success(()))
            }
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
    
    func encode<T: Encodable>(with model: T) -> Data {
        try! JSONEncoder().encode(model)
    }
}
