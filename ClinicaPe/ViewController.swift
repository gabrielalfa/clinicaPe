//
//  ViewController.swift
//  ClinicaPe
//
//  Created by Gabriel Seben on 12/04/2018.
//  Copyright © 2018 Intelecto Alpha. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView: UIImageView!
    
    let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePlusPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let Editimage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            plusPhotoButton.setImage(Editimage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let OriginalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            plusPhotoButton.setImage(OriginalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        dismiss(animated: true, completion: nil)
        
    }
    
    let singUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSingUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0 , alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleChange), for: .editingChanged)
        return textField
    }()
    
    @objc func handleChange(){
        let isFormText =
        emailTextField.text?.count ?? 0 > 0
        && UserNameTextField.text?.count ?? 0 > 0
        && PasswordTextField.text?.count ?? 0 > 0
        if isFormText {
            singUpButton.isEnabled = true
            singUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }else {
            singUpButton.isEnabled = false
            singUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    let UserNameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "User Name"
        textField.backgroundColor = UIColor(white: 0 , alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleChange), for: .editingChanged)
        return textField
    }()
    
    let PasswordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0 , alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleChange), for: .editingChanged)
        return textField
    }()
    
    @objc func handleSingUp(){
        
        if PasswordTextField.text?.count ?? 6 < 6 { showToast(message: "Password min 6")}
        
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let password = PasswordTextField.text, password.count > 0 else { return }
        guard let username = UserNameTextField.text, username.count > 0 else { return }
        
//        Auth.auth().createUser(withEmail: email, password: password){ (user: User?, error: Error?) in
//            if let err = error{
//                print("Failed to create user: ", err)
//                return
//            }
//
//            guard let image = self.plusPhotoButton.imageView?.image else { return }
//            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
//
//            Storage.storage().reference().child("profile_Image").putData(uploadData, metadata: nil, completion: { (metadata, err) in
//
//                if let err = err {
//                    print("Failed to upload profile_image: ", err)
//                    return
//                }
//
//                guard let profileImageUrl =  metadata?.downloadURL()?.absoluteString else { return }
//
//                print("Sucess to create: ", user?.uid ?? "")
//                guard let uid = user?.uid else { return }
//
//                let dictionaryValues = ["username": username, "profileImageURL": profileImageUrl]
//                let values = [uid : dictionaryValues]
//
//                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
//                    if let err = err{
//                        print("Failed to save user info db: ", err)
//                        return
//                    }
//                    print("Sussefull saved user info to db")
//                })
//
//                print("Successfully upload profille image: ", profileImageUrl)
//            })
        
           
           
//            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.ancor(top: view.topAnchor, left: nil, botton: nil, rigth: nil, paddingtop: 40, paddingleft: 0, paddingtopbotton: 0, paddingtopright: 0, width: 140, heigth: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
 
        setupImputFields()
        
        
    }
    
    fileprivate func setupImputFields(){
    
        let stackView = UIStackView(arrangedSubviews: [emailTextField, UserNameTextField, PasswordTextField, singUpButton])
    
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([])
        
        stackView.ancor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, botton: nil, rigth: view.rightAnchor, paddingtop: 20, paddingleft: 40, paddingtopbotton: 0, paddingtopright: 40, width: 0, heigth: 200)
        
        
    }
    
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        //toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension UIView {
    func ancor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, botton: NSLayoutYAxisAnchor?, rigth: NSLayoutXAxisAnchor?, paddingtop: CGFloat, paddingleft: CGFloat, paddingtopbotton: CGFloat, paddingtopright: CGFloat, width: CGFloat, heigth: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingtop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingleft).isActive = true
        }
        
        if let botton = botton {
            bottomAnchor.constraint(equalTo: botton, constant: paddingtopbotton).isActive = true
        }
        
        if let rigth = rigth {
            rightAnchor.constraint(equalTo: rigth, constant: -paddingtopright).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if heigth != 0 {
            heightAnchor.constraint(equalToConstant: heigth).isActive = true
        }
        
    }
}

