//
//  FileFeed.swift
//  witOrbit
//
//  Created by ZainAnjum on 08/02/2018.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//
import UIKit
import CoreData
class FileFeed: ChatFeeds, UIGestureRecognizerDelegate {
    
    let fileCellId = "cellId"
    var files : [Group_Files]?
    var ArrayOfFiles = [Group_Files]()
    let floaty = Floaty()
    
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
        
        floaty.addItem("Create new file", icon: UIImage(named: "next")!, handler: { item in
            self.chatRoomController?.handleFileFloaty()
            //            self.groups = self.chatRoomController?.group
        })
        floaty.sticky = true
        fetchData()
        
        addSubview(collectionView)
        addSubview(floaty)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|-40-[v0]|", views: collectionView)
        collectionView.register(FileCell.self, forCellWithReuseIdentifier: fileCellId)
        
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return files?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fileCellId, for: indexPath) as! FileCell
        cell.backgroundColor = .white
        print(indexPath.item)
        
        cell.files = files?[indexPath.item]
        loadData()
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }
    func fetchData() {
        do {
            let data = try context.fetch(Group_Files.fetchRequest())
            ArrayOfFiles = data as! [Group_Files]
            for each in data {
                
            }
            
        }
        catch  {
            
        }
    }
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext{
            
            files = [Group_Files]()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Group_Files")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "file_created_time", ascending: true)]
            fetchRequest.predicate = NSPredicate(format: "group.group_name = %@", (groups?.group_name)!)
            
            do{
                let fetchedFile = try(context.fetch(fetchRequest) as? [Group_Files])
                files?.append(contentsOf: fetchedFile!)
            }catch let error{
                print(error)
            }
        }
        files = files?.sorted(by: {$0.file_created_time!.compare($1.file_created_time!) == .orderedDescending})
    }
    
    
    @objc func tap(sender: UITapGestureRecognizer){
        
        if   let indexPath = self.collectionView.indexPathForItem(at: sender.location(in: self.collectionView)){
            let cell = self.collectionView.cellForItem(at: indexPath)
            
            let alert = UIAlertController(title: files?[indexPath.item].file_title, message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.left
            paragraphStyle.lineSpacing = 5
            
            let messageText = NSMutableAttributedString(
                string: "",
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
            let actionSheet = UIAlertController(title:"" , message: files?[indexPath.item].file_title, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Update File", style: .default, handler: { (UIAlertAction) in
                
            }))
            actionSheet.addAction(UIAlertAction(title: "Delete File", style: .default, handler: { (UIAlertAction) in
                
                
                
                print(self.files?[indexPath.row])
                context.delete((self.files?[indexPath.row])!)
                do {
                    try context.save()
                    self.files?.remove(at: indexPath.row)
                    //                    self.ArrayOfNotifications.removeAll()
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
