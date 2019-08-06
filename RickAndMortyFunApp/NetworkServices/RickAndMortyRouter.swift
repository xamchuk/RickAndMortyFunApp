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
    case getEpisode(page: Int)
    case getSingleLocation(id: String)
    case getSingleCharacter(id: Int)
    case getResidents(ids: String)

    var method: HTTPMethod {
        switch self {
        case .getCharacters, .getLocation, .getEpisode, .getSingleLocation, .getSingleCharacter, .getResidents:
            return .get
        }
    }

    var params: ([String: Any]?) {
        switch self {
        case .getCharacters(let page), .getLocation(let page), .getEpisode(let page):
            return ["page": String(page)]
        case .getSingleLocation, .getSingleCharacter, .getResidents:
            return nil
        }
    }

    var url: URL {
        var relativePath: String = ""
        switch self {
        case .getCharacters:
            relativePath = "character"
        case .getLocation:
            relativePath = "location"
        case .getEpisode:
            relativePath = "episode"
        case .getSingleLocation(let id):
            relativePath = "location/\(id)"
        case .getSingleCharacter(let id):
                   relativePath = "character/\(id)"
        case .getResidents(let ids):
                          relativePath = "character/\(ids)"
        }

        let url = baseURL.appendingPathComponent(relativePath)
        return url
    }

    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
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
