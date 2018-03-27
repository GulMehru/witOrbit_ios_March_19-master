//
//  VideoCell.swift
//  youtube
//
//  Created by Gul Mehru on 1/24/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
class BaseClass: UICollectionViewCell{
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class VideoCell: BaseClass, UIGestureRecognizerDelegate {
    
    
    var files: Group_Files? {
        didSet {
            titleLabel.text = files?.file_title
            dateView.text = files?.file_created_time 
        }
    }
    
    var notification: Group_Notifications? {
        didSet {
            titleLabel.text = notification?.notification_title
            subTitleView.text = notification?.notification_detail
            dateView.text = notification?.notification_created_time
            
        }
    }
    
    var video1: Group_Messages? {
        didSet {
            
            
            titleLabel.text = video1?.group?.group_name
            subTitleView.text = video1?.message_text
          
        }
    }
    
    
    
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
  
    
    
//    var video: Groups? {
//        didSet {
//            titleLabel.text = video?.group_name
//            subTitleView.text = video?.group_description
//             subTitleView.text = video?.created_date
////            userProfileImageView.image = UIImage(
////
////            if let profileImageName = video?.profileImageName {
////                userProfileImageView.image = UIImage(named: profileImageName)
////                subTitleView.text = video?.name
////            }
//
//
//        }
//    }
    
    let messageTextView: UILabel = {
        let textView = UILabel()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample"
        textView.numberOfLines = 0
        textView.textColor = .black
        return textView
    }()
    
    let textBubbleView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
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
   
    let downloadButtonView: UIButton = {
        let button = UIButton()
        button.setFAIcon(icon: .FAArrowCircleODown, iconSize: 30, forState: .normal)
        button.setFATitleColor(color: .black, forState: .normal)
        return button
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
    
   
    
    func FileCell() {
        addSubview(titleLabel)
        addSubview(dateView)
        addSubview(downloadButtonView)
        addConstraintsWithFormat(format: "H:|-20-[v0]", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-20-[v0]", views: dateView)
        addConstraintsWithFormat(format: "H:[v0]-8-|", views: downloadButtonView)
        
        addConstraintsWithFormat(format: "V:|-10-[v0]-8-[v1]", views: titleLabel, dateView)
        addConstraintsWithFormat(format: "V:|-10-[v0]", views: downloadButtonView)
    }
    
    func messageChatCell() {
       
//        typeTextField.addConstraintsWithFormat(format: "H:[v0]-3-|", views: sendButtonView)
//        typeTextField.addConstraintsWithFormat(format: "V:|[v0]|", views: sendButtonView)
    }
    
    override func setupViews() {
        cellWithDp()
       
    }
}
//    var cellLabel: UILabel!
//    var pan: UIPanGestureRecognizer!
//    var deleteLabel1: UILabel!
//    var deleteLabel2: UILabel!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    private func commonInit() {
//        self.contentView.backgroundColor = UIColor.white
//        self.backgroundColor = UIColor.red
//
//        cellLabel = UILabel()
//        cellLabel.textColor = UIColor.white
//        cellLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.addSubview(cellLabel)
//        cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//        cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
//        cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
//        cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
//
//        deleteLabel1 = UILabel()
//        deleteLabel1.text = "delete"
//        deleteLabel1.textColor = UIColor.white
//        self.insertSubview(deleteLabel1, belowSubview: self.contentView)
//
//        deleteLabel2 = UILabel()
//        deleteLabel2.text = "delete"
//        deleteLabel2.textColor = UIColor.white
//        self.insertSubview(deleteLabel2, belowSubview: self.contentView)
//
//        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
//        pan.delegate = self
//        self.addGestureRecognizer(pan)
//    }
//
//    override func prepareForReuse() {
//        self.contentView.frame = self.bounds
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        if (pan.state == UIGestureRecognizerState.changed) {
//            let p: CGPoint = pan.translation(in: self)
//            let width = self.contentView.frame.width
//            let height = self.contentView.frame.height
//            self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
//            self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 100, height: height)
//            self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
//        }
//
//    }
//
//    @objc func onPan(_ pan: UIPanGestureRecognizer) {
//        if pan.state == UIGestureRecognizerState.began {
//
//        } else if pan.state == UIGestureRecognizerState.changed {
//            self.setNeedsLayout()
//        } else {
//            if abs(pan.velocity(in: self).x) > 500 {
//                let collectionView: UICollectionView = self.superview as! UICollectionView
//                let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
//                collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
//            } else {
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.setNeedsLayout()
//                    self.layoutIfNeeded()
//                })
//            }
//        }
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
//    }
//
//}
//
