//
//  NotificationFeed.swift
//  witOrbit
//
//  Created by Gul Mehru on 2/7/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData

class NotificationFeed: ChatFeeds, UIGestureRecognizerDelegate {
    
    
    let cellId1 = "cellId"
    let notificationCellId = "notificationCellId"
    let floaty = Floaty()
    var notifications : [Group_Notifications]?
    var ArrayOfNotifications = [Group_Notifications]()
    override var groups : Groups?{
        didSet{
            print(groups?.group_name)
            //            clearData()
            collectionView.reloadData()
            loadData()
            
        }
    }
    
    func reload() {
        
    }
    
    var chatRoomController: ChatRoomController?
    

    override func setupViews() {
        super.setupViews()
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(lpgr)
        
        floaty.addItem("Create new notification", icon: UIImage(named: "next")!, handler: { item in
            self.chatRoomController?.handleNotificationFloaty()
            //            self.groups = self.chatRoomController?.group
        })
        floaty.sticky = true
        fetchData()
        
        addSubview(collectionView)
        addSubview(floaty)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|-40-[v0]|", views: collectionView)
        collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: notificationCellId)
        
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationCellId, for: indexPath) as! NotificationCell
        cell.backgroundColor = .white
        print(indexPath.item)
        
        cell.notification = notifications?[indexPath.item]
        loadData()
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }
    func fetchData() {
        do {
            let data = try context.fetch(Group_Notifications.fetchRequest())
            ArrayOfNotifications = data as! [Group_Notifications]
            for each in data {
                
            }
            
        }
        catch  {
            
        }
    }
     func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            
            notifications = [Group_Notifications]()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Group_Notifications")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "notification_created_time", ascending: true)]
            fetchRequest.predicate = NSPredicate(format: "group.group_name = %@", (groups?.group_name)!)
            
            do{
                let fetchedNotification = try(context.fetch(fetchRequest) as? [Group_Notifications])
                notifications?.append(contentsOf: fetchedNotification!)
            }catch let error{
                print(error)
            }
        }
        notifications = notifications?.sorted(by: {$0.notification_created_time!.compare($1.notification_created_time!) == .orderedDescending})
    }
    
    
    @objc func tap(sender: UITapGestureRecognizer){
        
        if   let indexPath = self.collectionView.indexPathForItem(at: sender.location(in: self.collectionView)){
            let cell = self.collectionView.cellForItem(at: indexPath)
        
            let alert = UIAlertController(title: notifications?[indexPath.item].notification_title, message: "\n\n\(String(describing: notifications?[indexPath.item].notification_detail))", preferredStyle: UIAlertControllerStyle.alert)
           
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.left
            paragraphStyle.lineSpacing = 5
            
            let messageText = NSMutableAttributedString(
                string: (notifications?[indexPath.item].notification_detail)!,
                attributes: [
                    NSAttributedStringKey.paragraphStyle: paragraphStyle,
                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)
                ]
            )
            
            alert.setValue(messageText, forKey: "attributedMessage")
            // show the alert
        
        if let window = UIApplication.shared.keyWindow{
            window.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
            
            
            
    }
         else {
            print("collection view was tapped")
        }
    }

    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        
        if (gestureRecognizer.state != UIGestureRecognizerState.ended){
            return
        }
        let p = gestureRecognizer.location(in: self.collectionView)
        
        if let indexPath : NSIndexPath = (self.collectionView.indexPathForItem(at: p))! as NSIndexPath{
//            print(notifications?[indexPath.item])
//            print(indexPath.item)
//            let chatRoomController = ChatRoomController()
//            chatRoomController.showAlert()
            let actionSheet = UIAlertController(title:"" , message: notifications?[indexPath.item].notification_title, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Update Notification", style: .default, handler: { (UIAlertAction) in
                
                let alert1:UIAlertController?
                
                
                alert1 = UIAlertController(title: "Update Notification", message: "",  preferredStyle: .alert)
                alert1?.addTextField(
                    configurationHandler: {(textField: UITextField!) in
                        textField.placeholder = self.notifications?[indexPath.item].notification_title
                })
                alert1?.addTextField(
                    configurationHandler: {(textField: UITextField!) in
                        textField.placeholder = self.notifications?[indexPath.item].notification_detail
                })
                alert1?.addAction(UIKit.UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { alert -> Void in
                    
                    if let textFields = alert1?.textFields {
                        let theTextFields = textFields as [UITextField]
                        let title = theTextFields[0].text
                        let detail = theTextFields[1].text
                    
                    do {
                        if title != nil || detail != nil {
                        self.notifications?[indexPath.item].notification_title = title
                        self.notifications?[indexPath.item].notification_detail = detail
                        }
                        if title == nil {
                            let oldTitle = self.notifications?[indexPath.item].notification_title
                            self.notifications?[indexPath.item].notification_title =  oldTitle
                            self.notifications?[indexPath.item].notification_detail = detail
                        }
                        if detail == nil {
                            self.notifications?[indexPath.item].notification_title = title
                            self.notifications?[indexPath.item].notification_detail = self.notifications?[indexPath.item].notification_detail
                        }
                        try context.save()
                        self.collectionView.reloadData()
                        
                    }
                     catch {
                       
                    }
                    }
                }))
                
                if let window = UIApplication.shared.keyWindow{
                    window.rootViewController?.present(alert1!, animated: true, completion: nil)
                }
                
            }))
            actionSheet.addAction(UIAlertAction(title: "Delete Notification", style: .default, handler: { (UIAlertAction) in
               
                
                print(self.notifications?[indexPath.row])
                context.delete((self.notifications?[indexPath.row])!)
                do {
                    try context.save()
                    self.notifications?.remove(at: indexPath.row)
                   self.fetchData()
                    self.collectionView.reloadData()
                }
                catch {
                    
                }
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel ", style: .cancel, handler: nil))
            if let window = UIApplication.shared.keyWindow{
                window.rootViewController?.present(actionSheet, animated: true, completion: nil)
            }
        }
        
        
    }
    
}

