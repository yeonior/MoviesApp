//
//  MainTabBarViewController.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let firstVC = UINavigationController(rootViewController: HomeViewController())
        let secondVC = UINavigationController(rootViewController: UpcomingViewController())
        let thirdVC = UINavigationController(rootViewController: SearchViewController())
        let fourthVC = UINavigationController(rootViewController: DownloadsViewController())
        
        firstVC.tabBarItem.image = UIImage(systemName: "house")
        secondVC.tabBarItem.image = UIImage(systemName: "play")
        thirdVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        fourthVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        firstVC.title = "Home"
        secondVC.title = "Coming Soon"
        thirdVC.title = "Top Search"
        fourthVC.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([firstVC, secondVC, thirdVC, fourthVC], animated: true)
    }
}
