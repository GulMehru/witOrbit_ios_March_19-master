//
//  verifyPhoneController.swift
//  witOrbit
//
//  Created by Gul Mehru on 1/29/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
class VerifyPhoneController: UIViewController {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mobile")
        //imageView.layer.cornerRadius = 22
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
    
    let codeLabel: UILabel = {
        let label1 = UILabel()
        label1.text = "Enter verification code"
        label1.textColor = UIColor.white
        label1.textAlignment = .center
        return label1
    }()
    
    let textView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.white
        text.textAlignment = .left
//        text.addTarget(nil, action:"firstResponderAction:", for:.editingDidEndOnExit)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        let image =  UIImage(named: "icon_next")
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    let welcomlabel: UILabel = {
        let label1 = UILabel()
        label1.text = "Verify your phone number"
        label1.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        label1.textAlignment = .center
        return label1
    }()
    var phoneNumber:String = ""
    @objc func codeVerify() {
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "c42d36dc-92e6-682e-de61-f40ce6d59e4b"
        ]
        
        guard let verificationCode = textView.text else { return }
        
        
        print(verificationCode)
        if textView.text!.isEmpty
            
        {
            print("Enter Verification")
        }
            
        else {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.1.1.10:8080/witorbit_new/index.php?display=m_signupactivity&phone=\(phoneNumber)&code=\(verificationCode)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                guard let responseFromUrl = data else { return }
                let string = String(data: responseFromUrl, encoding: .utf8)
                print(string)
            }
        })
        print(phoneNumber)
        dataTask.resume()
            
    }
    }
    
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(lowerView)
        view.addSubview(logoImageView)
        view.addSubview(codeLabel)
        view.addSubview(textView)
        view.addSubview(welcomlabel)
        view.addSubview(nextButton)
        view.addSubview(barView)
        
        
        view.addConstraintsWithFormat(format: "H:|[v0(200)]", views: barView)
        view.addConstraintsWithFormat(format: "V:[v0(5)][v1(\(self.view.frame.height / 2.5))]|", views: barView, lowerView)
        
        view.addConstraintsWithFormat(format: "H:[v0(80)]", views: logoImageView)
        view.addConstraintsWithFormat(format: "V:|-100-[v0(75)]", views: logoImageView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: codeLabel)
        view.addConstraintsWithFormat(format: "V:|-250-[v0]|", views: codeLabel)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerView)
//        view.addConstraintsWithFormat(format: "V:[v0(\(self.view.frame.height / 3))]|", views: lowerView)
        view.addConstraintsWithFormat(format: "H:[v0(200)]", views: textView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: textView)
        textView.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: lowerView.centerYAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:[v0]", views: welcomlabel)
        view.addConstraintsWithFormat(format: "V:[v0]-380-|", views: welcomlabel)
        welcomlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
        }
    }
    @objc func buttonAction()  {
       // self.present(profileController(), animated: true, completion: nil)
        
        
           self.navigationController?.pushViewController(CompleteProfileController(), animated: true)
    }
    
}
