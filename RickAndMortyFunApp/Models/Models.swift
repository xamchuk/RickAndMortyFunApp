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

    var imageUrl: String {
        let nameArray = name.components(separatedBy: " ")
        var epis: Substring = ""
        if episode.suffix(2) == "10" {
            epis = episode.suffix(2)
        } else {
            epis = episode.suffix(1)
        }
        let body = "http://watchrickandmorty.eu/wp-content/uploads/2018/07/Watch-Rick-and-Morty-Season-\(season.suffix(1))-Episode-\(epis)-"
        var name = ""
        for i in nameArray {
            name += i.capitalizingFirstLetter() + "-"
        }
        let url = body + name + "350x230"//"\(nameArray.first!)-\(nameArray.last!)-350x230"
        if season.suffix(1) == "3" {

            return "http://watchrickandmorty.eu/wp-content/uploads/2018/07/watch-rick-and-Morty-Season-3-Episode-\(epis)-350x230"
        }
        return url
    }
}
