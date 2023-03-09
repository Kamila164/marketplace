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
    
    func fetchProduct() async throws -> [Product] {
        let request = URLRequest(url: baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        let model: Products = self.decode(with: data)
        return model.products
    }
    
    func searchproduct(by word: String) async throws -> [Product] {
        let url = baseURL.appendingPathComponent("search")
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [.init(name: "q", value: word)]
        
        guard let url = urlComponents?.url else {
            return []
        }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let model: Products = self.decode(with: data)
        return model.products
    }
    
    func addNewProdduct(with model: Product) async throws -> Void {
        let url = baseURL.appendingPathComponent("add")
        var request = URLRequest(url: url)
        request.httpMethod = HTTPRequest.POST.rawValue
        request.httpBody = encode(with: model)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, _) = try await URLSession.shared.data(for: request)
        return ()
        
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
        .resume()
    }
    
    func deleteProduct(with id: Int) async throws -> Void {
        let url = baseURL.appendingPathComponent("\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HTTPRequest.DELETE.rawValue
        
        let (_, _) = try await URLSession.shared.data(for: request)
        return ()
    }
    
    func fetchCategory() throws -> [Category] {
        let data = Data(categoryJSON.utf8)
        return decode(with: data)
    }
    
    func fetchService() throws -> [Service] {
        let data = Data(serviceJSON.utf8)
        return decode(with: data)
    }
    
    func decode<T: Decodable>(with data: Data) -> T {
        try! JSONDecoder().decode(T.self, from: data)
    }
    
    func encode<T: Encodable>(with model: T) -> Data {
        try! JSONEncoder().encode(model)
    }
}
