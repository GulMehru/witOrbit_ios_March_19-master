//
//  CreateGroupController.swift
//  witOrbit
//
//  Created by Gul Mehru on 2/19/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit
import CoreData

class CreateGroupController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    var image: UIImage?
    let openButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
        button.setFAIcon(icon: .FAUserPlus, iconSize: 55, forState: .normal)
        button.setFATitleColor(color: UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1), forState: .normal)
//        button.layer.cornerRadius = button.frame.width / 2
        return button
    }()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func imagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel ", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Name"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(16)
        return label
    }()
    
    let nameTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(16)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(16)
        return label
    }()
    
    let descriptionTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(16)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    
    let universityLabel: UILabel = {
        let label = UILabel()
        label.text = "University"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(16)
        return label
    }()
    
    let universityTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(16)
        text.keyboardType = UIKeyboardType.default
        return text
    }()
    let departmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Department"
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(16)
        return label
    }()
    
    let departmentTextView: UITextField = {
        let text = HoshiTextField()
        text.layer.masksToBounds = true
        text.borderInactiveColor = UIColor.darkGray
        text.borderActiveColor = UIColor(red: 14/255 , green: 116/255 , blue: 130/255 , alpha: 1)
        text.textAlignment = .left
        text.font = text.font?.withSize(16)
        text.keyboardType = UIKeyboardType.default
        return text
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
        button.setTitle("Create", for: .normal)
        button.addTarget(self, action: #selector(insertData), for: .touchUpInside)
        return button
    }()
    
    func fetchData() {
        do {
            let data = try context.fetch(Groups.fetchRequest())
            numberOfGroups = data as! [Groups]
        }
        catch  {
            
        }
    }
    var uni = ["FAST National University", "University of Agriculture, Faisalabad", "Government College University, Faisalabad", "Government College Women University (Faisalabad)"]
    var dept = ["Computing", "Engineering", "Management Sciences", "Sciences & Humanities"]
    var uniPickerView = UIPickerView()
    var deptPickerView = UIPickerView()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows : Int = uni.count
        if pickerView == deptPickerView {
            countRows = self.dept.count
        }
        return countRows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == uniPickerView{
           self.universityTextView.text = self.uni[row]
//            self.uniPickerView.isHidden = true
        }
        
        else if pickerView == deptPickerView {
            self.departmentTextView.text = self.dept[row]
//            self.deptPickerView.isHidden = true
            
        }
        
        universityTextView.text = uni[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        if pickerView == uniPickerView {
            let titleRow = uni[row]
            return titleRow
        }
        else if pickerView == deptPickerView {
            let titleRow = dept[row]
            return titleRow
        }
    return ""
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.universityTextView) {
            self.uniPickerView.isHidden = false
        }
        else if (textField == self.departmentTextView) {
            self.deptPickerView.isHidden = false
        }
    }
    
   
    var numberOfGroups = [Groups]()
    @objc func insertData() {
    
        let delegate = UIApplication.shared.delegate as? AppDelegate
        print(numberOfGroups.count)
         if (nameTextView.text?.isNotEmpty)! && (descriptionTextView.text?.isNotEmpty)! {
        if let context = delegate?.persistentContainer.viewContext{
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Groups", into: context) as! Groups
            steve.group_name = nameTextView.text
            if image == nil {
                image = #imageLiteral(resourceName: "itempire-web")
            }
            else {
                let imageData = UIImageJPEGRepresentation( image!, 1)
                steve.img_link = imageData as! Data
            }
            if numberOfGroups.count == 0{
                steve.group_id = 1
                }
                else{
                    steve.group_id = Int16(numberOfGroups.count) + 1
                }

            steve.created_date = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
        }
        do{
            try(context.save())
        }catch let error{
            print(error)
        }
            
//            self.dismiss(animated: true, completion: nil)
//            let layout = UICollectionViewFlowLayout()
//            let controller = GroupsController(collectionViewLayout: layout)
            navigationController?.pushViewController(GroupLinkController(), animated: true)
        }
        else{
            let alert = UIAlertController(title: "Sorry", message: "Fill all required fields (*) .", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
}
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let title = UILabel()
        title.text = "Create Groups"
        title.textColor = UIColor.white
        navigationItem.titleView = title
        uniPickerView.delegate = self
        uniPickerView.dataSource = self
        deptPickerView.delegate = self
        deptPickerView.dataSource = self
        fetchData()
        print(numberOfGroups.count)
        view.addSubview(openButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextView)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(universityLabel)
        view.addSubview(universityTextView)
        view.addSubview(departmentLabel)
        view.addSubview(departmentTextView)
        view.addSubview(lowerView)
        view.addSubview(createButton)
        universityTextView.inputView = uniPickerView
        departmentTextView.inputView = deptPickerView
        
        openButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraintsWithFormat(format: "V:|-70-[v0(120)]", views: openButton)
        view.addConstraintsWithFormat(format: "H:[v0(120)]", views: openButton)
//        openButton.layer.cornerRadius = 40
        view.addConstraintsWithFormat(format: "H:|-10-[v0]", views: nameLabel)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameTextView)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]", views: descriptionLabel)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: descriptionTextView)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]", views: universityLabel)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: universityTextView)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]", views: departmentLabel)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: departmentTextView)
        view.addConstraintsWithFormat(format: "V:|-250-[v0]-10-[v1(25)]-10-[v2]-10-[v3(25)]-10-[v4]-10-[v5(25)]-10-[v6]-10-[v7(25)]", views: nameLabel, nameTextView, descriptionLabel, descriptionTextView, universityLabel, universityTextView, departmentLabel, departmentTextView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: lowerView)
        view.addConstraintsWithFormat(format: "V:[v0(\(self.view.frame.height / 10))]|", views: lowerView)
        view.addConstraintsWithFormat(format: "H:[v0(70)]", views: createButton)
        view.addConstraintsWithFormat(format: "V:[v0(30)]", views: createButton)
        createButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor).isActive = true
        createButton.centerYAnchor.constraint(equalTo: lowerView.centerYAnchor).isActive = true
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
         image = info[UIImagePickerControllerOriginalImage] as! UIImage
         openButton.setImage(image, for: .normal)
//         openButton.imageView?.heightAnchor.constraint(equalToConstant: 120).isActive = true
//         openButton.imageView?.widthAnchor.constraint(equalToConstant: 120).isActive = true
         openButton.imageView?.layer.cornerRadius = 60
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil )
    }
    

}
