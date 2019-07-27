//
//  TabBarController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

     let characterViewController = CharacterViewController()
     let locationViewController = LocationViewController()
     let episodeViewController = EpisodeViewController()

// MARK: - Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = #colorLiteral(red: 0.08234158903, green: 0.08236020058, blue: 0.08233750612, alpha: 1)
        tabBar.tintColor = .white
        setupViewControllers()
        setupTabBarItems()
    }

// MARK: - Setup UI
    fileprivate func setupViewControllers() {
        let characterNavController = UINavigationController(rootViewController: characterViewController)
        let locationNavController = UINavigationController(rootViewController: locationViewController)
        let episodeNavController = UINavigationController(rootViewController: episodeViewController)

        self.viewControllers = [characterNavController, locationNavController, episodeNavController]
    }

    fileprivate func setupTabBarItems() {
        guard let items = tabBar.items else { return }

        let characterTabBarItem = items[0] as UITabBarItem
        characterTabBarItem.title = NSLocalizedString("Characters", comment: "Person, ")
        characterTabBarItem.image = #imageLiteral(resourceName: "charactersIcon")
        characterTabBarItem.selectedImage = #imageLiteral(resourceName: "charactersIconSelected")
        characterViewController.navigationItem.title = characterTabBarItem.title

        let locationTabBarItem =  items[1] as UITabBarItem
        locationTabBarItem.title = NSLocalizedString("Locations", comment: "TableView by places, locations or dimensions ")
        locationTabBarItem.image = #imageLiteral(resourceName: "loacionsIcon")
        locationTabBarItem.selectedImage = #imageLiteral(resourceName: "loacionsIconSelected")
        locationViewController.navigationItem.title = locationTabBarItem.title

        let episodeTabBarItem =  items[2] as UITabBarItem
        episodeTabBarItem.title = NSLocalizedString("Episodes", comment: "")
        episodeTabBarItem.image = #imageLiteral(resourceName: "episodesIcon")
        episodeTabBarItem.selectedImage = #imageLiteral(resourceName: "episodesIconSelected")
        episodeViewController.navigationItem.title = episodeTabBarItem.title
    }
}
