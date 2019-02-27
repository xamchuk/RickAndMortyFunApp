//
//  NetworkService.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 26/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Alamofire
import Foundation

enum NetworkError: Error {
    case invalidURL
}

class NetworkService {

    let urlString = "https://rickandmortyapi.com/api/character/"
    var task: URLSessionTask?
    
    func loadCharcters(matching query: String?, page: Int, completion: @escaping(CharactersResult) -> Void) {

        func fireErrorCompletion(_ error: Error?) {
            completion(CharactersResult(characters: nil, error: error,
                                        currentPage: 0, pageCount: 0))
        }

        var queryOrEmpty = "since:1970-01-02"
        var name = "query"
        if let query = query, !query.isEmpty {
            queryOrEmpty = query
            name = "name"
        }
        var components = URLComponents(string: urlString)
        components?.queryItems = [
            URLQueryItem(name: name, value: queryOrEmpty),
            URLQueryItem(name: "page", value: String(page))
        ]
        guard let url = components?.url else {
            fireErrorCompletion(NetworkError.invalidURL)
            return
        }
        task?.cancel()

        AF.request(url).responseJSON() { response in
                if let error = response.error {
                    guard (error as NSError).code != NSURLErrorCancelled else {
                        return
                    }
                    fireErrorCompletion(error)
                    return
                }
                guard let data = response.data else {
                    fireErrorCompletion(response.error)
                    return
                }
                do {
                    let characters = try JSONDecoder().decode(Characters.self, from: data)
                    completion(CharactersResult(characters: characters.results,
                                                    error: nil,
                                              currentPage: page,
                                                pageCount: Int(characters.info.pages)))
                } catch {
                    fireErrorCompletion(error)
                }
        }
        task?.resume()
    }
}
