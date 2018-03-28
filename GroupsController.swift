//
//  ViewController.swift
//  youtube
//
//  Created by Gul Mehru on 1/20/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData

class GroupsController:  UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate {

    let floaty = Floaty()
    
    func clearData() {
        
        do {
            
            let entityNames = ["Groups"]
            
            for entityName in entityNames {
                
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                
                let objects = try(context.fetch(fetchRequest)) as? [NSManagedObject]
                
                for object in objects! {
                    context.delete(object)
                }
            }
            
            try(context.save())
            
            
        } catch let err {
            print(err)
        }
        
    }
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Groups")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        request.sortDescriptors = [NSSortDescriptor(key: "lastMessage.date", ascending: false)]
//        request.predicate = NSPredicate(format: "lastMessage != nil")
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    var blockOperation = [BlockOperation]()
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert{
            blockOperation.append(BlockOperation(block: {
                self.collectionView?.insertItems(at: [newIndexPath!])
            }))
        }
        if type == .delete{
            
            self.collectionView?.deleteItems(at: [indexPath!])
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            for operations in blockOperation{
                operations.start()
            }
        }, completion: { (completed) in
            let lastItem = self.fetchedResultsController.sections![0].numberOfObjects - 1
            let indexPath = NSIndexPath(item: lastItem, section: 0)
            self.collectionView?.scrollToItem(at:  indexPath as IndexPath, at: .bottom, animated: true)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        collectionView?.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floaty)
        
       initializeFetchedResultsController()
        
//        clearData()
        navigationController?.navigationBar.isTranslucent = false
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(lpgr)
         floaty.addItem("Create new group", icon: UIImage(named: "next")!, handler: { item in
//
           self.navigationController?.pushViewController(CreateGroupController(), animated: true)
            
        })
        floaty.addItem("One-to-One Chat", icon: UIImage(named: "next")!, handler: { item in
//           
            self.navigationController?.pushViewController(CreateGroupController(), animated: true)
        })
        
        floaty.sticky = true 
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.reloadData()
        
    }
    
    
    let layout = UICollectionViewFlowLayout()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let controller = ChatRoomController(collectionViewLayout: layout)
        controller.group = fetchedResultsController.object(at: indexPath) as? Groups
        
       
        navigationController?.pushViewController(controller, animated: true)
       
    }
    func reloadCollectionView() {
        collectionView?.reloadData()
    }
 
    @objc func handleMore() {
        
    }
    
    @objc func handleSearch() {
        print(123)
    }
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()

    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        let group = fetchedResultsController.object(at: indexPath) as? Groups
//        print(group?.group_name)
        cell.video = group

        return cell
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
   
    
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        
        if (gestureRecognizer.state != UIGestureRecognizerState.ended){
            return
        }
        let p = gestureRecognizer.location(in: self.collectionView)
        
        if let indexPath : NSIndexPath = (self.collectionView?.indexPathForItem(at: p))! as NSIndexPath{
        
            let group = fetchedResultsController.object(at: indexPath as IndexPath) as? Groups
            let actionSheet = UIAlertController(title:"" , message: group?.group_name, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Update Group", style: .default, handler: { (UIAlertAction) in
                
                let alert1:UIAlertController?
                
                
                alert1 = UIAlertController(title: "Details", message: "",  preferredStyle: .alert)
               
                alert1?.addAction(UIKit.UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { alert -> Void in
                    
                    
                    let controller = DetailsViewController()
                    controller.group = self.fetchedResultsController.object(at: indexPath as IndexPath) as? Groups
                    
                    
                }))
                
                if let window = UIApplication.shared.keyWindow{
                    window.rootViewController?.present(alert1!, animated: true, completion: nil)
                }
                
            }))
            actionSheet.addAction(UIAlertAction(title: "Delete Group", style: .default, handler: { (UIAlertAction) in
                
                let group = self.fetchedResultsController.object(at: indexPath as IndexPath) as? Groups
                context.delete(group!)
                do {
                try context.save()
                
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


