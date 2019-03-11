//
//  CharacterModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 26/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

struct ItemsResponse<T: Codable>: Codable, ResponseType {
    var info: Info
    var results: [T]
}

struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String
    var prev: String
}

struct Character: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: Location
    var image: String
    var episode: [String]
    var url: String
}

struct Origin: Codable {
    var name: String
    var url: String
}

struct Location: Codable {
    var id: Int?
    var name: String
    var type: String?
    var dimension: String?
    var residents: [String]?
    var url: String
}

struct Episode: Codable {
    var id: Int?
    var name: String?
    var airDate: String?
    var episode: String
    var characters: [String]?
    var url: String?
    var season: String {
        return String(episode.prefix(3))
    }
}

