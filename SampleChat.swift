//
//  SampleChat.swift
//  witOrbit
//
//  Created by Gul Mehru on 2/20/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData


class SampleChat: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var group: Groups? {
        didSet {
           navigationItem.title = group?.group_name
            print("Group:\(self.group?.group_name)")
           // navigationItem.title = "new"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
    }
}
