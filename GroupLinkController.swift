//
//  GroupLinkController.swift
//  witOrbit
//
//  Created by Gul Mehru on 3/26/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit

class GroupLinkController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Created Sucessfully"
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = label.font.withSize(16)
        return label
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "itempire-web")
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let groupNameLabel: UILabel = {
        let label = UILabel()
        label.text = "UCP BSCS 6th Semester"
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = label.font.withSize(16)
        return label
    }()
    
    let codeLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Code"
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = label.font.withSize(16)
        return label
    }()
    let codeTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(16)
        text.keyboardType = UIKeyboardType.default
        text.placeholder = "2812"
        text.placeholderColor = UIColor.lightGray
        return text
    }()
    let linkLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Link"
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = label.font.withSize(16)
        return label
    }()
    let linkTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(16)
        text.keyboardType = UIKeyboardType.default
        text.placeholder = "http:/itempire.org/corm"
        text.placeholderColor = UIColor.lightGray
        return text
    }()
    let shareLabel: UILabel = {
        let label = UILabel()
        label.text = "Share"
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = label.font.withSize(16)
        return label
    }()
    let shareButton: UIButton = {
        let button = UIButton()
//        button.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
        button.setFAIcon(icon: .FAShareAlt, iconSize: 20, forState: .normal)
        button.setFATitleColor(color: UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1), forState: .normal)
        //        button.layer.cornerRadius = button.frame.width / 2
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
        // button.titleLabel?.text = "CREATE"
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(insertData), for: .touchUpInside)
        return button
    }()
    @objc func insertData() {
        let layout = UICollectionViewFlowLayout()
        let controller = GroupsController(collectionViewLayout: layout)
        navigationController?.pushViewController(CustomtabBarController(), animated: true)
//        navigationController?.pushViewController(controller, animated: true)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let title = UILabel()
        title.text = "New Group"
        title.textColor = UIColor.white
        navigationItem.titleView = title
        view.addSubview(titleLabel)
        view.addSubview(userProfileImageView)
        view.addSubview(groupNameLabel)
        view.addSubview(codeLabel)
        view.addSubview(codeTextView)
        view.addSubview(linkLabel)
        view.addSubview(linkTextView)
        view.addSubview(shareLabel)
        view.addSubview(shareButton)
        view.addSubview(lowerView)
        view.addSubview(createButton)
        
        view.addConstraintsWithFormat(format: "H:[v0]", views: titleLabel)
        view.addConstraintsWithFormat(format: "H:[v0(60)]", views: userProfileImageView)
        view.addConstraintsWithFormat(format: "H:[v0]", views: groupNameLabel)
        view.addConstraintsWithFormat(format: "H:[v0]", views: codeLabel)
        view.addConstraintsWithFormat(format: "H:[v0]", views: codeTextView)
        view.addConstraintsWithFormat(format: "H:[v0]", views: linkLabel)
        view.addConstraintsWithFormat(format: "H:[v0]", views: linkTextView)
        view.addConstraintsWithFormat(format: "H:[v0]", views: shareLabel)
        view.addConstraintsWithFormat(format: "H:[v0]", views: shareButton)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerView)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userProfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        codeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        codeTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        linkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        linkTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "V:|-100-[v0]-25-[v1(60)]-25-[v2]-25-[v3]-20-[v4(25)]-25-[v5]-20-[v6(25)]-25-[v7]-25-[v8]", views: titleLabel, userProfileImageView, groupNameLabel, codeLabel, codeTextView, linkLabel, linkTextView, shareLabel, shareButton)
        view.addConstraintsWithFormat(format: "V:[v0(\(self.view.frame.height / 11))]|", views: lowerView)
        view.addConstraintsWithFormat(format: "H:[v0(70)]", views: createButton)
        view.addConstraintsWithFormat(format: "V:[v0(30)]", views: createButton)
        createButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        createButton.centerYAnchor.constraint(equalTo: lowerView.centerYAnchor).isActive = true
    }
}
