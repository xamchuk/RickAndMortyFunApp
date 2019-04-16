//
//  LVC.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 20/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LVC: UIViewController {
    let networkService = NetworkService()
    let vc: LView = .fromNib()
    var id: String?
    var item: Location? {
        didSet {
            let characterId = returnId(from: randomImageUrl(from: item!)?.first)
            vc.imageView.setImage(from: "https://rickandmortyapi.com/api/character/avatar/\(characterId ?? "999").jpeg",
                                size: CGSize(width: 100, height: 100))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(vc)
        vc.fillSuperview()
        guard let id = id else { return }
        fetchLocation(from: id)
    }

    func returnId(from urlString: String?) -> String? {
        guard let stringUrl = urlString else { return nil }
        let url = URL(string: stringUrl)
        return url?.lastPathComponent
    }

    func fetchLocation(from id: String) {
        networkService.loadSingle(request: RickAndMortyRouter.getSingleLocation(id: id)) { [weak self] (response: Location) in
            self?.item = response
        }
    }

    func randomImageUrl(from item: Location) -> [String]? {
        var array = [String]()
        guard let imageUrlArray = item.residents else { return nil }
        for _ in 0...3 {
            array.append(imageUrlArray.randomElement() ?? "")
        }
        return array
    }
}
