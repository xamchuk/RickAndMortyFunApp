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

struct CharacterOfShow: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
}

struct CharacterDetails {
    var isButton: Bool
    var title: String
    var value: String
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
    var name: String
    var airDate: String?
    var episode: String
    var characters: [String]?
    var url: String?
    var season: String {
        return String(episode.prefix(3))
    }
}
