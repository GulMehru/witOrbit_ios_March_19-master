//
//  profile.swift
//  witOrbit
//
//  Created by Gul Mehru on 1/28/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit

class CompleteProfileController: UIViewController {
    
    
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addpicture")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let lowerView: UIView = {
        let view2 = UIView()
        view2.backgroundColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        view2.translatesAutoresizingMaskIntoConstraints = false
        return view2
    }()
    let cPro: UILabel = {
        let label1 = UILabel()
        label1.text = "Complete your profile"
        label1.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        label1.textAlignment = .center
        label1.font = label1.font.withSize(16)
        return label1
    }()
    let label1: UILabel = {
        let label = UILabel()
        label.text = "Full Name"
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = label.font.withSize(13)
       return label
    }()
    
    let textView: UITextField = {
    let text = HoshiTextField()
    text.layer.masksToBounds = true
    text.borderInactiveColor = UIColor.darkGray
    text.textAlignment = .left
//    text.addTarget(nil, action:"firstResponderAction:", for:.editingDidEndOnExit)
    text.keyboardType = UIKeyboardType.default
    return text
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = label.font.withSize(13)
        return label
    }()
    let textView1: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.textAlignment = .left
//        text.addTarget(nil, action:"firstResponderAction:", for:.editingDidEndOnExit)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = label.font.withSize(13)
        return label
    }()
    let textView2: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.textAlignment = .left
//        text.addTarget(nil, action:"firstResponderAction:", for:.editingDidEndOnExit)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    
    let barView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.blue
        view.backgroundColor = UIColor(red: 20/255 , green: 154/255 , blue: 173/255 , alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_next")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    // let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(cPro)
        view.addSubview(logoImageView)
        view.addSubview(lowerView)
        view.addSubview(label1)
        view.addSubview(textView)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(textView1)
        view.addSubview(textView2)
        view.addSubview(nextButton)
        view.addSubview(barView)
        
        
        view.addConstraintsWithFormat(format: "H:|[v0(300)]", views: barView)
        view.addConstraintsWithFormat(format: "V:[v0(5)][v1(\(self.view.frame.height / 2.5))]|", views: barView, lowerView)
        
        
        view.addConstraintsWithFormat(format: "H:|-50-[v0(250)]", views: textView)
        view.addConstraintsWithFormat(format: "V:[v0(20)]-200-|", views: textView)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]|", views: label1)
        view.addConstraintsWithFormat(format: "V:[v0]-230-|", views: label1)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]|", views: label2)
        view.addConstraintsWithFormat(format: "V:[v0]-170-|", views: label2)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]|", views: label3)
        view.addConstraintsWithFormat(format: "V:[v0]-110-|", views: label3)
        view.addConstraintsWithFormat(format: "H:|-50-[v0(250)]", views: textView1)
        view.addConstraintsWithFormat(format: "V:[v0(20)]-140-|", views: textView1)
        view.addConstraintsWithFormat(format: "H:|-50-[v0(250)]", views: textView2)
        view.addConstraintsWithFormat(format: "V:[v0(20)]-80-|", views: textView2)
        view.addConstraintsWithFormat(format: "H:[v0]", views: cPro)
        view.addConstraintsWithFormat(format: "V:[v0]-380-|", views: cPro)
        cPro.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerView)
        //view.addConstraintsWithFormat(format: "V:|-410-[v0]|", views: lowerView)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:[v0(90)]", views: logoImageView)
        view.addConstraintsWithFormat(format: "V:|-100-[v0(90)]", views: logoImageView)
        view.addConstraintsWithFormat(format: "H:[v0(50)]", views: nextButton)
        view.addConstraintsWithFormat(format: "V:[v0(50)]-30-|", views: nextButton)
        nextButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        
        
        
        
}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if textView.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
            if textView1.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
            if textView2.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
       
    }

  
    
    
   
    @objc func buttonAction()  {
       // self.present(groupController(), animated: true, completion: nil)
   //  self.present(profileCreatedController(), animated: true, completion: nil)
   self.navigationController?.pushViewController(ProfileCreatedController(), animated: true)
    }
}
