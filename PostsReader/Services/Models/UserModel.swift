//
//  UserModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct UserModel: Decodable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: UserAddress?
    var phone: String
    var website: String
    var company: UserCompany?
}

struct UserAddress: Decodable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: AddressGeocode
}

struct AddressGeocode: Decodable {
    var lat: String
    var lng: String
}

struct UserCompany: Decodable {
    var name: String
    var catchPhrase: String
    var bs: String
}

extension UserModel: Describable {
    
    var attributedDescription: NSAttributedString {
        
        let description = "Author\n"
            .with(alignment: .center)
            .with(font: UIFont.boldSystemFont(ofSize: 18))
            .addLineSpacing(spacing: 6)
        
        description.append(create(propertyName: "Name", value: name))
        description.append(create(propertyName: "Username", value: username))
        description.append(create(propertyName: "Email", value: email))
        description.append(create(propertyName: "Phone", value: phone))
        description.append(create(propertyName: "Website", value: website))
        
        return description
    }
    
    private func create(propertyName: String, value: String) -> NSAttributedString {
        let string = "\(propertyName.localized): ".with(font: UIFont.boldSystemFont(ofSize: 16)).mutable
        string.append("\(value)\n".with(font: UIFont.systemFont(ofSize: 16)))
        return string
    }
}

