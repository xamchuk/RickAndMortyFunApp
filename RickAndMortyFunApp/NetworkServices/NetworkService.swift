//
//  NetworkService.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 26/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Alamofire

enum NetworkError: Error {
    case invalidURL
}

class NetworkService {

    func loadCharacters(page: Int, completion: @escaping(CharactersResult) -> Void) {

        func fireErrorCompletion(_ error: Error?) {
            completion(CharactersResult(characters: nil, error: error,
                                        currentPage: 0, pageCount: 0))
        }
        let request = RickAndMortyRouter.getCharacters(page: page)
        AF.request(request).responseDecodable {
            (response: DataResponse<Characters>) in
            if let error = response.error {
                guard (error as NSError).code != NSURLErrorCancelled else {
                    return
                }
                fireErrorCompletion(error)
                return
            }
            guard let characters = response.value else { return }
            completion(CharactersResult(characters: characters,
                                        error: nil,
                                        currentPage: page,
                                        pageCount: Int(characters.info.pages)))
        }
    }

    func load<T: Codable>(state: RickAndMortyRouter , completion: @escaping(T) -> Void) {

        func fireErrorCompletion(_ error: Error?) {
           // completion(T)
        }
        let request = state
        AF.request(request).responseDecodable {
            (response: DataResponse<T>) in
            if let error = response.error {
                guard (error as NSError).code != NSURLErrorCancelled else {
                    return
                }
                fireErrorCompletion(error)
                return
            }
            guard let items = response.value else { return }
            completion(items)
        }
    }


}
