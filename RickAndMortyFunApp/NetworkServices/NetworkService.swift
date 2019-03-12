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

class NetworkService<Response> where Response: ResponseType & Decodable {
    func loadItems(request: URLRequestConvertible,
                   page: Int,
                   completion: @escaping (Result<Response.Model>) -> Void) {
        AF.request(request).responseDecodable { (response: DataResponse<Response>) in
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
}

class Network<Model: Codable> {
    func loadItems(request: URLRequestConvertible,
                   page: Int,
                   completion: @escaping (DataResponse<Model>) -> Void) {
        AF.request(request).responseDecodable { (response: DataResponse<Model>) in
            completion(response)
        }
    }
}
