//
//  UserProfileHeader.swift
//  ClinicaPe
//
//  Created by Gabriel Seben on 14/04/2018.
//  Copyright © 2018 Intelecto Alpha. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.blue
        
        addSubview(profileImageView)
        profileImageView.ancor(top: topAnchor, left: self.leftAnchor, botton: nil, rigth: nil, paddingtop: 12, paddingleft: 12, paddingtopbotton: 0, paddingtopright: 0, width: 80, heigth: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupProfileImage()
        
    }

    fileprivate func setupProfileImage() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            guard let profileImageUrl = dictionary["profileImageURL"] as? String else { return }
            guard let url = URL(string: profileImageUrl) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
               
                guard let data = data else{ return }
                let image = UIImage(data: data)
                
                //tread assincrona buscar imagem
                
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
                
            }.resume()
            
        }) { (err) in
            print("Failed to fetch user: ", err)
        }
        
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
