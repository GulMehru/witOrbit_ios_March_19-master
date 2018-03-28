//
//  TableCellTableViewCell.swift
//  witOrbit
//
//  Created by Gul Mehru on 3/27/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit



class TableCell: UITableViewCell {

    var video: Groups? {
        didSet {
            titleLabel.text = video?.group_name
            
            subTitleView.text = video?.lastMessage?.message_text
            if let date = video?.lastMessage?.date {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                dateView.text = dateFormatter.string(from: date)
            }
            
            //            dateView.text = video?.created_date
            if video?.img_link == nil {
                userProfileImageView.image = #imageLiteral(resourceName: "itempire-web")
            }
            else {
                userProfileImageView.image = UIImage(data: (video?.img_link)!)
            }
        }
        
    }
    
        // Configure the view for the selected state
   
    
    let thumbNailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "itempire-web")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "itempire-web")
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha:1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Office will be closed tommorrow"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleView: UILabel = {
        let textView = UILabel()
        textView.text = "Office will be closed tommorrow"
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
   
    
    let dateView: UILabel = {
        let textView = UILabel()
        textView.text = "9:30 AM"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    func cellWithDp() {
        
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleView)
        addSubview(dateView)
        
        addConstraintsWithFormat(format: "H:|-95-[v0]", views: titleLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: dateView)
        addConstraintsWithFormat(format: "H:|-95-[v0]", views: subTitleView)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1]", views: titleLabel, subTitleView)
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: dateView)
        addConstraintsWithFormat(format: "H:|-16-[v0(70)]", views: userProfileImageView)
        //addConstraintsWithFormat(format: "V:|-8-[v0(44)]", views: userProfileImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0(70)]-16-[v1(1)]|", views:  userProfileImageView,seperatorView)
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: seperatorView)
        
        
    }
   
    
     func setupViews() {
        cellWithDp()
        
    }

}
