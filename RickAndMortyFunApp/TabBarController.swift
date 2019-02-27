//
//  TabBarController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var networkService: NetworkService

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupViewControllers() {

        let characterViewController = CharacterViewController(networkService: networkService)
        let characterNavController = UINavigationController(rootViewController: characterViewController)

        let locationViewController = LocationViewController()
        let locationNavController = UINavigationController(rootViewController: locationViewController)

        let episodeViewController = EpisodeViewController()
        let episodeNavController = UINavigationController(rootViewController: episodeViewController)

        self.viewControllers = [characterNavController, locationNavController, episodeNavController]

        guard let items = tabBar.items else { return }

        let characterTabBarItem = items[0] as UITabBarItem
        characterTabBarItem.title = NSLocalizedString("Characters", comment: "Person, ")
        characterViewController.navigationItem.title = characterTabBarItem.title

        let locationTabBarItem =  items[1] as UITabBarItem
        locationTabBarItem.title = NSLocalizedString("Locations", comment: "TableView by places, locations or dimensions ")
        locationViewController.navigationItem.title = locationTabBarItem.title

        let episodeTabBarItem =  items[2] as UITabBarItem
        episodeTabBarItem.title = NSLocalizedString("Episodes", comment: "")
        episodeViewController.navigationItem.title = episodeTabBarItem.title

    }
}
