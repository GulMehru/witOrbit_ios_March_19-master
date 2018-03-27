//
//  created.swift
//  witOrbit
//
//  Created by Gul Mehru on 1/29/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit

class ProfileCreatedController: UIViewController {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_tick")
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
        label1.text = "Profile created"
        label1.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        label1.textAlignment = .center
        label1.font = label1.font.withSize(16)
        return label1
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_next")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    let barView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.blue
        view.backgroundColor = UIColor(red: 20/255 , green: 154/255 , blue: 173/255 , alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startLabel: UILabel = {
        let label1 = UILabel()
        label1.text = "Let's start"
        label1.textColor = UIColor.white
        label1.textAlignment = .center
        return label1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //view.addSubview(nextButton)
        view.addSubview(barView)
        view.addSubview(cPro)
        view.addSubview(logoImageView)
        view.addSubview(lowerView)
        view.addSubview(startLabel)
        lowerView.addSubview(nextButton)
        
        
        
        
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: barView)
        view.addConstraintsWithFormat(format: "V:[v0(5)][v1(\(self.view.frame.height / 2.5))]|", views: barView, lowerView)
        
        view.addConstraintsWithFormat(format: "H:[v0(90)]", views: logoImageView)
        view.addConstraintsWithFormat(format: "V:|-100-[v0(90)]", views: logoImageView)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerView)
       // view.addConstraintsWithFormat(format: "V:|-350-[v0]|", views: lowerView)
        lowerView.addConstraintsWithFormat(format: "H:[v0(50)]", views: nextButton)
        lowerView.addConstraintsWithFormat(format: "V:[v0(50)]-30-|", views: nextButton)
        nextButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:[v0]", views: cPro)
        view.addConstraintsWithFormat(format: "V:[v0]-380-|", views: cPro)
        cPro.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "H:[v0]", views: startLabel)
        view.addConstraintsWithFormat(format: "V:[v0]", views: startLabel)
        startLabel.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        startLabel.centerYAnchor.constraint(equalTo: lowerView.centerYAnchor).isActive = true
      
    }
    let layout = UICollectionViewFlowLayout()
    @objc func buttonAction()  {
      //  self.present(profileController(), animated: true, completion: nil)
               // self.navigationController?.pushViewController(profileController(), animated: true)
        let ExploreController = GroupsController(collectionViewLayout: layout)
            self.navigationController?.pushViewController(ExploreController, animated: true)
     // self.present(ExploreController, animated: true, completion: nil)
    }
}
