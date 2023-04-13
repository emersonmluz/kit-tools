//
//  ApiManager.swift
//  kit-tools
//
//  Created by Émerson M Luz on 10/04/23.
//

import Foundation

class ApiManager {
    static var shared = ApiManager()
    
    func apiRequest<T: Decodable>(url: String, endpoint: String, modelType: T.Type, completion: @escaping((_: T) -> Void)) {
        let url = URL(string: url + endpoint)
        
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared

            let task = session.dataTask(with: request) { data, _, error in
                if let data = data, error == nil {
                    do {
                        let dateFormat = DateFormatter()
                        dateFormat.dateFormat = "yyyy-MM-dd"
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(dateFormat)
                        let decoderResponse = try decoder.decode(modelType.self, from: data)
                        DispatchQueue.main.async {
                            completion(decoderResponse)
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
