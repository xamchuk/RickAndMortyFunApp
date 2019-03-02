//
//  RickAndMortyRouter.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 02/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Alamofire

enum RickAndMortyRouter: URLRequestConvertible {
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api/")!
    }

    case getCharacters(Int)
    case create([String: Any])
    case delete(Int)

    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getCharacters:
                return .get
            default:
                return .get
            }
        }

        let params: ([String: Any]?) = {
            switch self {
            case .getCharacters(let page):
                return ["?page=": String(page)]
            default:
                return nil
            }
        }()

        let url: URL = {
            var relativePath: String = ""
            switch self {
            case .getCharacters:
                relativePath = "character"
            default:
                break
            }
            let url = baseURL.appendingPathComponent(relativePath)
            return url
        }()

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return  URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: params)
    }
}
