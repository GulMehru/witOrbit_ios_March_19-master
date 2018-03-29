//
//  ChatFeed.swift
//  witOrbit
//
//  Created by Gul Mehru on 2/7/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData


class ChatFeeds: BaseClass , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, NSFetchedResultsControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let cellId = "cellId"
    let chatCellId = "chatCellId"
    var image: UIImage?
    
    var groups : Groups?{
        didSet{
//            clearData()
//            initializeFetchedResultsController()
            do {
                try fetchedResultsController.performFetch()
            } catch let error {
                print(error)
            }
        }
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.LightBlue()
        return cv
    }()
   
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your message..."
        return textField
    }()
    
    let sendButon: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    let moreButon: UIButton = {
        let button = UIButton(type: .system)
        button.setFAIcon(icon: .FAPlus, iconSize: 20, forState: .normal)
        return button
    }()
    let messageInputContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
   
  
    var bottomConstraint: NSLayoutConstraint?
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Group_Messages")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "group.group_name = %@", (groups?.group_name)!)
        request.fetchLimit = 10
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    //need to scroll on insert.
    var blockOperation = [BlockOperation]()
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert{
            blockOperation.append(BlockOperation(block: {
                self.collectionView.insertItems(at: [newIndexPath!])
            }))
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            for operations in blockOperation{
                operations.start()
            }
        }, completion: { (completed) in
//            print(ne)
        })
    }
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|-30-[v0]-20-|", views: collectionView)
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: chatCellId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillHide, object: nil)
        collectionView.backgroundColor = .white
        
        
        addSubview(messageInputContainerView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
        addConstraintsWithFormat(format: "V:[v0(40)]", views: messageInputContainerView)
        setupInputTextField()
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        addConstraint(bottomConstraint!)
        
        setupInputTextField()

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
    func setupInputTextField(){
        let topBorder = UIView()
        topBorder.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButon)
        messageInputContainerView.addSubview(moreButon)
//        sendButon.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
        sendButon.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        moreButon.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
//         moreButon.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        messageInputContainerView.addSubview(topBorder)
        messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0(20)]-8-[v1][v2(60)]|", views: moreButon,inputTextField, sendButon)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: sendButon)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: moreButon)
        
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0(0.5)]", views: topBorder)
        messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBorder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return fetchedResultsController.sections?[section].numberOfObjects ?? 0
     
    }
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        if collectionView == self.collectionView{
            return true
        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector , forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatCellId, for: indexPath) as! ChatCell
//    cell.backgroundColor = UIColor.LightBlue()
    let message = fetchedResultsController.object(at: indexPath) as! Group_Messages
    cell.messageTextView.text = message.message_text
    
    if let messageText = message.message_text{
    
    
        print(message.message_img)
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        if message.isSender == false{
            cell.messageTextView.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)

            cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
            cell.profileImageView.isHidden = false
            cell.bubbleImageView.image = ChatCell.grayBubbleImage
            cell.messageTextView.textColor = UIColor.black
            cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
        }else{
            cell.profileImageView.isHidden = true
            cell.messageTextView.frame = CGRect(x: frame.width - estimatedFrame.width - 16 - 16 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)

            cell.textBubbleView.frame = CGRect(x: frame.width - estimatedFrame.width - 16 - 8 - 16 - 10, y: 0, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
            cell.bubbleImageView.image = ChatCell.blueBubbleImage
            cell.messageTextView.textColor = .white
            cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        }
        if let messageImage = message.message_img{
            
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            //        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
            if let estimatedFrame = UIImage(data: messageImage)?.size{
                
                print(estimatedFrame)
                
                if message.isSender == false{
                    cell.contentView.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    
                    cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
                    cell.profileImageView.isHidden = false
                    cell.bubbleImageView.image = ChatCell.grayBubbleImage
                    cell.messageTextView.textColor = UIColor.black
                    cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                }else{
                    cell.profileImageView.isHidden = true
                    cell.contentView.frame = CGRect(x: frame.width - estimatedFrame.width - 16 - 16 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    
                    cell.textBubbleView.frame = CGRect(x: frame.width - estimatedFrame.width - 16 - 8 - 16 - 10, y: 0, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                    cell.bubbleImageView.image = ChatCell.blueBubbleImage
                    cell.messageTextView.textColor = .white
                    cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                }
            }
        }
    }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = fetchedResultsController.object(at: indexPath) as! Group_Messages
        if let messageText = message.message_text{
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18) ], context: nil)
            return CGSize(width: frame.width, height: estimatedFrame.height + 20)
        }
        return CGSize(width: frame.width, height: 100)
    }
    
  
    func createMessageWithText(text:String, group: Groups, minutesAgo: Double, context: NSManagedObjectContext,isSender:Bool = false ) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Group_Messages", into: context) as! Group_Messages

        message.message_text = text
        message.group = group
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
        message.isSender = isSender
        groups?.lastMessage = message
    }
    func createMessageWithImage(Data:Data, group: Groups, minutesAgo: Double, context: NSManagedObjectContext,isSender:Bool = false ) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Group_Messages", into: context) as! Group_Messages
        

        message.message_img = Data
        message.group = group
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
        message.isSender = isSender
        groups?.lastMessage = message
    }
    @objc func imagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            imagePicker.sourceType = .camera
            if let window = UIApplication.shared.keyWindow{
                window.rootViewController?.present(imagePicker, animated: true, completion: nil)
            }
//            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            if let window = UIApplication.shared.keyWindow{
            window.rootViewController?.present(imagePicker, animated: true, completion: nil)
            }
//            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel ", style: .cancel, handler: nil))
        if let window = UIApplication.shared.keyWindow{
            window.rootViewController?.present(actionSheet, animated: true, completion: nil)
        }
//        self.present(actionSheet, animated: true, completion: nil)
        
    }
    func clearData() {
        
        do {
            
            let entityNames = ["Group_Messages"]
            
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
    
    @objc func handleMore() {
        let importMenu = UIDocumentMenuViewController(documentTypes: [], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        if let window = UIApplication.shared.keyWindow{
            window.rootViewController?.present(importMenu, animated: true, completion: nil)
        }
        
    }
    @objc func handleSend() {
              let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        createMessageWithText(text: inputTextField.text!, group: self.groups!, minutesAgo: 0, context: context, isSender: true)
        do {
            try context.save()
            inputTextField.text = nil
        } catch let error {
            print(error)
        }
        
        
    }
    @available(iOS 8.0, *)
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        
        let cico = url as URL
        print(cico)
        
        
        //optional, case PDF -> render
        //displayPDFweb.loadRequest(NSURLRequest(url: cico) as URLRequest)
        
        
        
        
    }
    
    @available(iOS 8.0, *)
    public func documentMenu(_ documentMenu:     UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        if let window = UIApplication.shared.keyWindow{
            window.rootViewController?.present(documentPicker, animated: true, completion: nil)
        }
    }
    
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        print("we cancelled")
        if let window = UIApplication.shared.keyWindow{
            window.rootViewController?.dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    func indexPathIsValid(indexPath: NSIndexPath) -> Bool {
        if indexPath.section >= collectionView.numberOfSections {
            print(indexPath.section)
            return false
        }
        if indexPath.row >= collectionView.numberOfItems(inSection: indexPath.section) {
            print(indexPath.row)
            return false
        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(30,0,120,0)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardframe = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            let isKeyboardShowing = notification.name == .UIKeyboardWillShow
            bottomConstraint?.constant = isKeyboardShowing ?  -((keyboardframe?.height)!) : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
            }, completion: { (completed) in
                if self.fetchedResultsController.sections![0].numberOfObjects != 0{
                    if isKeyboardShowing{
                        let lastItem = self.fetchedResultsController.sections![0].numberOfObjects - 1
                        print(self.fetchedResultsController.sections![0].numberOfObjects)
                        let indexPath = NSIndexPath(item: lastItem, section: 0)
                        self.collectionView.contentInset = UIEdgeInsetsMake(30, 0, 180, 0)
                        self.collectionView.scrollToItem(at:  indexPath as IndexPath, at: .top , animated: true)
                    }else{
                        self.collectionView.contentInset = UIEdgeInsetsMake(30, 0, 20, 0)
                    }
                }
            })
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        var imageData: Data? = UIImageJPEGRepresentation( image!, 1)
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext

        createMessageWithImage(Data: imageData as! Data, group: self.groups!, minutesAgo: 0, context: context)
        do {
            try context.save()

        } catch let error {
            print(error)
        }




//        openButton.setImage(image, for: .normal)
        //         openButton.imageView?.heightAnchor.constraint(equalToConstant: 120).isActive = true
        //         openButton.imageView?.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        openButton.imageView?.layer.cornerRadius = 60

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil )
    }

    
    
    }
    

