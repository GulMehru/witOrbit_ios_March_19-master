//
//  ViewController.swift
//  youtube
//
//  Created by Gul Mehru on 1/20/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData

class ChatRoomController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var group_id : Int?
    

    var group: Groups? {
        didSet {
            let titleLabel = UILabel()
            titleLabel.text = group?.group_name
            titleLabel.textAlignment = .left
            titleLabel.textColor = UIColor.white
            navigationItem.titleView = titleLabel
//            let imageView = UIImageView(image: UIImage(data: (group?.img_link)!))
//            imageView.layer.cornerRadius = 20
//            
//            let item = UIBarButtonItem(customView: imageView)
//            self.navigationItem.rightBarButtonItem = item
        }
    }
    
    let cellId = "cellId"
    let notificationCellId = "notificationCellId"
    let fileCellId = "fileCellId"
    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        navigationController?.navigationBar.isTranslucent = false
      
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
        
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.orange
        collectionView?.register(ChatFeeds.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(NotificationFeed.self, forCellWithReuseIdentifier: notificationCellId)
        collectionView?.register(FileFeed.self, forCellWithReuseIdentifier: fileCellId)
//        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.isPagingEnabled = true
        
    }
    
    func handleNotificationFloaty() {
        
        let uploadNotification = UploadNotification()
        uploadNotification.groups = group
        let navEditorViewController: UINavigationController = UINavigationController(rootViewController: uploadNotification)
        self.present(navEditorViewController, animated: true, completion: nil)

    }
    func handleFileFloaty() {
        let uploadFile = UploadFile()
        uploadFile.groups = group
        let navEditorViewController: UINavigationController = UINavigationController(rootViewController: uploadFile)
        self.present(navEditorViewController, animated: true, completion: nil)        
    }
    func showAlert() {
       
        print("alert")
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupNavBarButtons() {
//        let searchImage = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
//
//        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
//        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
//        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
//
    }
    
    @objc func handleMore() {
        
    }
    
    @objc func handleSearch() {
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatFeeds
            cell.backgroundColor = UIColor.LightBlue()
            cell.groups = group
            return cell
        }
        
        else if indexPath.item == 1 {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: notificationCellId , for: indexPath) as! NotificationFeed
            cell.backgroundColor = UIColor.LightBlue()
            cell.groups = group
            cell.chatRoomController = self
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fileCellId , for: indexPath) as! FileFeed
            cell.backgroundColor = UIColor.LightBlue()
            cell.groups = group
            cell.chatRoomController = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
}
