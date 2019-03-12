//
//  TabBarController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    fileprivate func setupViewControllers() {

        let characterViewController = CharacterViewController()
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
