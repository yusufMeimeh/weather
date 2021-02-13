//
//  API.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/6/21.
//

import Foundation

typealias CompletionCallback<T : Codable> = ((Swift.Result<T, CustomError>) -> Void)

class API{
    
    static func makeGetRequest<T:Codable>(with path : String , responseType : T.Type ,params : [String : String] = [:] , completion: @escaping CompletionCallback<T>){
        
        let session = URLSession.shared
        
        var urlBuilder = URLComponents()
        urlBuilder.scheme = Constants.scheme
        urlBuilder.host = Constants.host
        urlBuilder.path = path
       
        var queryItems =  [URLQueryItem]()
        queryItems.append(.init(name: Constants.ParameterKeys.appid, value: Constants.apiKey))
        params.forEach { (key , value) in
            queryItems.append(.init(name: key, value: value))
        }

        urlBuilder.queryItems = queryItems
        let url = urlBuilder.url!
        print(url.absoluteString)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                completion(.failure(CustomError.other(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(CustomError.string(description: "Server error!")))
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                completion(.failure(CustomError.string(description: "Wrong MIME type!")))
                return
            }
            
            if let data = data{
                let decoder = JSONDecoder()
                
                do {
                    let people = try decoder.decode(T.self, from: data)
                    completion(.success(people))
                } catch {
                    completion(.failure(CustomError.string(description: "JSON error: \(error.localizedDescription)")))
                    
                }
            }
        }
        task.resume()
    }
}


