//
//  CharacterModel.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 26/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import Foundation

import Foundation

struct CharactersResult {
    let characters: Characters?
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

struct Result<T> {
    let items: T?
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

struct Characters: Codable {
    var info: Info
    var results: [Character]
}

struct Locations: Codable {
    var info: Info
    var results: [Location]
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
   // var residents: [Character]?
    var url: String
}

