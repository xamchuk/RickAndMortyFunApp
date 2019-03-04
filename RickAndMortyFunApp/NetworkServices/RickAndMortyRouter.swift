//
//  RickAndMortyRouter.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 02/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Alamofire

enum RickAndMortyRouter {

    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api/")!
    }

    case getCharacters(page: Int)
    case getLocation(page: Int)

    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        case .getLocation:
            return .get
        }
    }

    var params: ([String: Any]?) {
        switch self {
        case .getCharacters(let page):
            return ["page": String(page)]
        case .getLocation(let page):
            return ["page": String(page)]
        }
    }

    var url: URL {
        var relativePath: String = ""
        switch self {
        case .getCharacters:
            relativePath = "character"
        case .getLocation:
            relativePath = "location"
        }

        let url = baseURL.appendingPathComponent(relativePath)
        return url
    }

    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return  URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}

extension RickAndMortyRouter: URLRequestConvertible {

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: params)
    }
}
