//
//  ViewController.swift
//  youtube
//
//  Created by Gul Mehru on 1/20/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData

class GroupsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {

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
       
        floaty.addItem("Create new group", icon: UIImage(named: "next")!, handler: { item in
//            let createGroup = CreateGroupController()
//            let navEditorViewController: UINavigationController = UINavigationController(rootViewController: createGroup)
//            self.present(navEditorViewController, animated: true, completion: nil)
//             self.present(CreateGroupController(), animated: true, completion: nil)
           self.navigationController?.pushViewController(CreateGroupController(), animated: true)
            
        })
        floaty.addItem("One-to-One Chat", icon: UIImage(named: "next")!, handler: { item in
//            let createGroup = CreateGroupController()
//            let navEditorViewController: UINavigationController = UINavigationController(rootViewController: createGroup)
//            self.present(navEditorViewController, animated: true, completion: nil)
//             self.present(CreateGroupController(), animated: true, completion: nil)
            self.navigationController?.pushViewController(CreateGroupController(), animated: true)
        })
        
        floaty.sticky = true 
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(doYourStuff), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    @objc func doYourStuff(){
       print(123)
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
        cell.video = group

        return cell
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
       var groups : [Groups]?
        context.delete((groups?[indexPath.row])!)
        do {
            try context.save()
            groups?.remove(at: indexPath.row)
            //                    self.ArrayOfNotifications.removeAll()
            
            collectionView.reloadData()
        }
        catch {
            
        }
        collectionView.deleteItems(at: [indexPath])
    }
}


