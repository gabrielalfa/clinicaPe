//
//  Cliente.swift
//  ClinicaPe
//
//  Created by Gabriel Seben on 16/04/2018.
//  Copyright © 2018 Intelecto Alpha. All rights reserved.
//

import Foundation

protocol Indentifiable {
    var id: String? { get set }
}

struct Clientes_Model : Codable, Indentifiable {
    
    var id: String? = nil
    let username: String
    let email: String
    let password: String
//    let profileImageName: String
//    let date: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
//        self.profileImageName = profileImageName
//        self.date = date
    }
    
}
