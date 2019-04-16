//
//  RickAndMortyFunAppTests.swift
//  RickAndMortyFunAppTests
//
//  Created by Rusłan Chamski on 14/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import XCTest
@testable import RickAndMortyFunApp

class RickAndMortyFunAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterCellViewModel() {
        let character = CharacterOfShow(id: 1,
                                        name: "Rick",
                                        status: "alive",
                                        species: "",
                                        type: "",
                                        gender: "",
                                        origin: Origin(name: "", url: ""),
                                        location: Location(id: 1, name: "", type: "", dimension: "", residents: [""], url: ""),
                                        image: "",
                                        episode: ["", ""],
                                        url: "")
        let charcterCellViewModel = CharacterCellViewModel(name: "Rick", imageURl: "", locationName: "")

        XCTAssertEqual(character.name, charcterCellViewModel.name)
    }
}
