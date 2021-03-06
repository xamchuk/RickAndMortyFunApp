//
//  NetworkService.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 26/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Alamofire

protocol ResponseType {
    associatedtype Model
    var info: Info { get }
    var results: [Model] { get }
}

struct Result<Model> {
    let items: [Model]?
    let error: Error?
    let currentPage: Int
    let pageCount: Int

    var hasMorePages: Bool {
        return currentPage < pageCount
    }

    var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
}

class NetworkService {
    func load<Model>(request: URLRequestConvertible, page: Int, completion: @escaping (Result<Model>) -> Void) where Model: Codable {
        AF.request(request).responseDecodable { (response: DataResponse<ItemsResponse<Model>> ) in
            if let error = response.error {
                guard (error as NSError).code != NSURLErrorCancelled else {
                    return
                }
                completion(Result(items: nil, error: error, currentPage: 0, pageCount: 0))
                return
            }

            guard let response = response.value else { return }

            let result = Result(
                items: response.results,
                error: nil,
                currentPage: page,
                pageCount: Int(response.info.pages)
            )
            completion(result)
        }
    }

    func loadSingle<Model: Codable>(request: URLRequestConvertible, completion: @escaping (Model) -> Void) {
        AF.request(request).responseDecodable { (response: DataResponse<Model>) in
            if let error = response.error {
                print("error: \(error)")
            }
            guard let item = response.value else { return }
            completion(item)
        }
    }

    func loadResidents<Model: Codable>(request: URLRequestConvertible, completion: @escaping (Model) -> Void) {
            AF.request(request).responseDecodable { (response: DataResponse<Model>) in
                if let error = response.error {
                    print("error: \(error)")
                }
                guard let item = response.value else { return }
                completion(item)
            }
        }
}
