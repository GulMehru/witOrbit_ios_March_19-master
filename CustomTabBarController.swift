//
//  CustomTabBarController.swift
//  witOrbit
//
//  Created by Gul Mehru on 3/10/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit

class CustomtabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        let titleLabel = UILabel()
        titleLabel.text = "WitOrbit"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = UIColor.red
//        navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        let layout = UICollectionViewFlowLayout()
        let groupController = GroupsController(collectionViewLayout: layout)
//        let recentGroup = UINavigationController(rootViewController: ExploreController)
        groupController.tabBarItem.title = "Groups"
        groupController.tabBarItem.setFAIcon(icon: .FAUsers)
        
        let singleChatController = UIViewController()
        singleChatController.view.backgroundColor = UIColor.blue
        singleChatController.tabBarItem.title = "One-to-One"
        singleChatController.tabBarItem.setFAIcon(icon: .FAUser)
        
        let contactsController = UIViewController()
        contactsController.tabBarItem.title = "Contacts"
        contactsController.tabBarItem.setFAIcon(icon: .FAAddressBook)
        
        self.viewControllers = [groupController, singleChatController, contactsController]
      
    }
}
