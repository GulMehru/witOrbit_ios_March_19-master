//
//  ViewController.swift
//  witOrbit
//
//  Created by Gul Mehru on 1/27/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIWebViewDelegate, UITextFieldDelegate{
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo1")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let lowerView: UIView = {
        let view2 = UIView()
        view2.backgroundColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        view2.translatesAutoresizingMaskIntoConstraints = false
        return view2
    }()
    
    let barView: UIView = {
       let view = UIView()
        //view.backgroundColor = UIColor.blue
       view.backgroundColor = UIColor(red: 20/255 , green: 154/255 , blue: 173/255 , alpha: 1)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let welcomlabel: UILabel = {
        let label1 = UILabel()
        label1.text = "Welcome to WitOrbit"
        label1.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        label1.textAlignment = .center
        return label1
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_next")
        button.setImage(image, for: .normal)
         button.addTarget(self, action: #selector(verifyPhone), for: .touchUpInside)
        return button
    }()
    
    
    let phoneLabel: UILabel = {
        let label1 = UILabel()
        label1.text = "Enter your phone number"
        label1.textColor = UIColor.white
        label1.textAlignment = .center
        return label1
    }()
    
    let textView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.textAlignment = .left
        text.borderInactiveColor = UIColor.white
//        text.addTarget(nil, action:"firstResponderAction:", for:.editingDidEndOnExit)      
        return text
    }()
    
    
    @objc func verifyPhone() {
//        let headers = [
//            "Cache-Control": "no-cache",
//            "Postman-Token": "05dd9a17-a7e2-66b2-29a7-09fde98a6374"
//        ]
//
//        guard let phoneNumber = textView.text else { return }
//        print(phoneNumber)
//
//        if textView.text!.isEmpty
//
//        {
//           print("Enter Number")
//        }
//
//        else {
//        let request = NSMutableURLRequest(url: NSURL(string: "http://10.1.1.10:8080/witorbit_new/index.php?display=m_signupactivity&phone=\(phoneNumber)")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                guard let responseFromUrl = data else { return }
//                let string = String(data: responseFromUrl, encoding: .utf8)
//                print(string)
//            }
//        })
//
//        dataTask.resume()
//
//            performSegue(withIdentifier: "dataTransfer", sender: Any?.self)
        
//        let ExploreController = GroupsController(collectionViewLayout: layout)
//        self.navigationController?.pushViewController(ExploreController, animated: true)
          self.navigationController?.pushViewController(CustomtabBarController(), animated: true)
     //   }
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        collectionView?.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true
        self.textView.delegate = self;
        super.viewDidLoad()
        view.addSubview(logoImageView)
        view.addSubview(lowerView)
        view.addSubview(welcomlabel)
        view.addSubview(textView)
        view.addSubview(phoneLabel)
        view.addSubview(nextButton)
        view.addSubview(barView)
        
        
        view.addConstraintsWithFormat(format: "H:|[v0(100)]", views: barView)
        view.addConstraintsWithFormat(format: "V:[v0(5)][v1(\(self.view.frame.height / 2.5))]|", views: barView, lowerView)
        
        
        view.addConstraintsWithFormat(format: "H:[v0(200)]", views: logoImageView)
        view.addConstraintsWithFormat(format: "V:|-50-[v0(110)]|", views: logoImageView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: phoneLabel)
        view.addConstraintsWithFormat(format: "V:|-250-[v0]|", views: phoneLabel)
        view.addConstraintsWithFormat(format: "H:[v0]", views: welcomlabel)
        view.addConstraintsWithFormat(format: "V:[v0]-380-|", views: welcomlabel)
        welcomlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:[v0(200)]", views: textView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: textView)
        view.addConstraintsWithFormat(format: "H:[v0(50)]", views: nextButton)
        view.addConstraintsWithFormat(format: "V:[v0(50)]-30-|", views: nextButton)
        nextButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        textView.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: lowerView.centerYAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerView)
       
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
//                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
//                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
//    
//    @objc func keyboardWillHide() {
//
//        self.view.frame.origin.y = 0
//        
//    }
//
//    @objc func keyboardWillChange(notification: NSNotification) {
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if textView.isFirstResponder {
//                self.view.frame.origin.y = -keyboardSize.height
//            }
//        }
//    }
    let layout = UICollectionViewFlowLayout()
    @objc func buttonAction()  {
        
        
        verifyPhone()
        //self.navigationController?.pushViewController(VerifyPhoneController(), animated: true)
//        let ExploreController = GroupsController(collectionViewLayout: layout)
//        self.navigationController?.pushViewController(ExploreController, animated: true)
    }

}




