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

        let charcterViewController = CharacterViewController()
        let characterNavController = UINavigationController(rootViewController: charcterViewController)

        let locationViewController = LocationViewController()
        let locationNavController = UINavigationController(rootViewController: locationViewController)

        let episodeViewController = EpisodeViewController()
        let episodeNavController = UINavigationController(rootViewController: episodeViewController)

        let searchViewController = SearchViewController()
        let searchNavController = UINavigationController(rootViewController: searchViewController)

        self.viewControllers = [characterNavController, locationNavController, episodeNavController, searchNavController]


        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.title = "Characters"
        charcterViewController.navigationItem.title = myTabBarItem1.title

        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.title = "Locations"
        locationViewController.navigationItem.title = myTabBarItem2.title

        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.title = "Episodes"
        episodeViewController.navigationItem.title = myTabBarItem3.title

        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.title = "Search"
        searchViewController.navigationItem.title = myTabBarItem4.title
    }
}
