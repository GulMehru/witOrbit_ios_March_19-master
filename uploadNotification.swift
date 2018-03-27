//
//  uploadNotification.swift
//  witOrbit
//
//  Created by Gul Mehru on 3/5/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData

class UploadNotification: UIViewController {
    var notifications : [Group_Notifications]?
    var groups : Groups?{
        didSet{
            print(groups?.group_name)
            createButton.addTarget(self, action: #selector(insertData), for: .touchUpInside)
            //            clearData()
            //            loadData()
            
            
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification Title"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(16)
        return label
    }()
    
    let titleTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(16)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    
    let notificationTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification Text"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(16)
        return label
    }()
    
    let notificationTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(16)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    
    let lowerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        
        return button
    }()
    
    @objc func insertData() {
        
        if let group = groups {
            
            createNotificationWithText(text: titleTextView.text!, textDetail: notificationTextView.text!, group: group, minutesAgo: 6, context: context)
            
            
        }
        
        do{
            try context.save()
        } catch let err {
            print(err)
        }
        
               loadData()
        
//        let upload2 = NotificationFeed()
//        upload2.collectionView.reloadData()
        
        
        self.dismiss(animated: true, completion: nil)
    }
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            
            notifications = [Group_Notifications]()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Group_Notifications")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "notification_created_time", ascending: false)]
            fetchRequest.predicate = NSPredicate(format: "group.group_name = %@", (groups?.group_name)!)
            
            do{
                let fetchedNotification = try(context.fetch(fetchRequest) as? [Group_Notifications])
                notifications?.append(contentsOf: fetchedNotification!)
            }catch let error{
                print(error)
            }
        }
        
//                notifications = notifications?.sorted(by: {$0.notification_created_time!.compare($1.notification_created_time!) == .orderedDescending})
    }
    
    
    func createNotificationWithText(text:String, textDetail: String, group: Groups, minutesAgo: Double, context: NSManagedObjectContext) {
        let notification = NSEntityDescription.insertNewObject(forEntityName: "Group_Notifications", into: context) as! Group_Notifications
        
        notification.notification_title = text
        notification.notification_detail = textDetail
        notification.group = group
        notification.notification_created_time = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
    
        UINavigationBar.appearance().backgroundColor =  UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        let title = UILabel()
        title.text = "Add Notification"
        title.textColor = UIColor.white
        navigationItem.titleView = title
        view.addSubview(titleLabel)
        view.addSubview(titleTextView)
        view.addSubview(notificationTextLabel)
        view.addSubview(notificationTextView)
        view.addSubview(lowerView)
        view.addSubview(createButton)
        
        view.addConstraintsWithFormat(format: "H:|-10-[v0]", views:titleLabel )
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: titleTextView)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]", views: notificationTextLabel)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: notificationTextView)
        view.addConstraintsWithFormat(format: "V:|-150-[v0]-5-[v1(25)]-50-[v2]-5-[v3(25)]", views: titleLabel, titleTextView, notificationTextLabel, notificationTextView)
        
        view.addConstraintsWithFormat(format: "V:[v0(\(self.view.frame.height / 10))]|", views: lowerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerView)
        view.addConstraintsWithFormat(format: "H:[v0(70)]", views: createButton)
        view.addConstraintsWithFormat(format: "V:[v0(30)]", views: createButton)
        createButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        createButton.centerYAnchor.constraint(equalTo: lowerView.centerYAnchor).isActive = true
    }
}
