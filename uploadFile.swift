//
//  uploadFile.swift
//  witOrbit
//
//  Created by Gul Mehru on 3/5/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData
class UploadFile: UIViewController, UIDocumentPickerDelegate {
    var files : [Group_Files]?
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
        label.text = "File Title"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(18)
        return label
    }()
    
    let titleTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(18)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    
    let fileLabel: UILabel = {
        let label = UILabel()
        label.text = "Attach file"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(18)
        return label
    }()
    
    let attachButtonView: UIButton = {
        let button = UIButton()
        button.setFAIcon(icon: .FAPaperclip, iconSize: 40, forState: .normal)
        button.setFATitleColor(color: .black, forState: .normal)
        button.addTarget(self, action: #selector(insertFile), for: .touchUpInside)
        return button
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
    
    @objc func insertFile() {
        
//        let file = UIDocumentPickerViewController()
//        file.delegate = self
//        init(documentTypes allowedUTIs: [String],
//        in mode: UIDocumentPickerMode)
        
    }
    @objc func insertData() {
        if let group = groups {
            
            createFileWithText(text: titleTextView.text!, group: group, minutesAgo: 6, context: context)
            
        }
        
        do{
            try context.save()
        } catch let err {
            print(err)
        }
        
        //       loadData()
        //        self.navigationController?.pushViewController(ChatRoomController(), animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func createFileWithText(text:String, group: Groups, minutesAgo: Double, context: NSManagedObjectContext) {
        let files = NSEntityDescription.insertNewObject(forEntityName: "Group_Files", into: context) as! Group_Files
        
        
          files.file_title = text
          files.file_created_time = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
          files.group = group
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        let title = UILabel()
        title.text = "Add Files"
        title.textColor = UIColor.white
        navigationItem.titleView = title
        view.addSubview(titleLabel)
        view.addSubview(titleTextView)
        view.addSubview(fileLabel)
        view.addSubview(attachButtonView)
        view.addSubview(lowerView)
        view.addSubview(createButton)
        
        view.addConstraintsWithFormat(format: "H:|-10-[v0]", views:titleLabel )
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: titleTextView)
        fileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        attachButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addConstraintsWithFormat(format: "V:|-120-[v0]-5-[v1(25)]-60-[v2]-5-[v3]" , views: titleLabel, titleTextView, fileLabel, attachButtonView)
        
        view.addConstraintsWithFormat(format: "V:[v0(\(self.view.frame.height / 10))]|", views: lowerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerView)
        view.addConstraintsWithFormat(format: "H:[v0(70)]", views: createButton)
        view.addConstraintsWithFormat(format: "V:[v0(30)]", views: createButton)
        createButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        createButton.centerYAnchor.constraint(equalTo: lowerView.centerYAnchor).isActive = true
        
        
    }
}

