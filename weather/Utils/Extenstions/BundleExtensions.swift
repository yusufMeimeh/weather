//
//  BundleExtensions.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/7/21.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String , completion: @escaping CompletionCallback<T>) {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            completion(.failure(.string(description: "Failed to locate \(file) in bundle.")))
            return
        }

        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(.string(description: "Failed to load \(file) from bundle.")))
            return
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            completion(.failure(.string(description: "Failed to decode \(file) from bundle.")))
            return
        }

        completion(.success(loaded))
    }
}
