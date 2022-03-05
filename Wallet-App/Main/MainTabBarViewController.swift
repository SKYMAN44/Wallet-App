//
//  MainTabBarViewController.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tabBar.isTranslucent = true
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemBackground
        
        let homeVC = HomeViewController()
        let historyVC = HistoryViewController()
        
        let navHomeVC = UINavigationController(rootViewController: homeVC)
        let navHistoryVC = UINavigationController(rootViewController: historyVC)

        navHomeVC.tabBarItem.image = UIImage(systemName: "homekit")
        navHistoryVC.tabBarItem.image = UIImage(systemName: "book")

        self.setViewControllers(
            [
                navHomeVC,
                navHistoryVC
            ],
            animated: false
        )

        for (tabBarItem) in tabBar.items! {
            tabBarItem.title = ""
        }

        self.selectedIndex = 0
    }

}
