//
//  ErrorsService.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

enum GenericError: Error {

    case userNotExists
    case cannotParseData
    case unknown
    case generic(Error)
    
    
    var localizedDescription: String {
        switch self {
        case .userNotExists:
            return NSLocalizedString("User with given email doesn't exist", comment: "user_not_exist")
        case .unknown:
            return NSLocalizedString("Unknown error. Please, contact support", comment: "unknown")
        case .cannotParseData:
            return NSLocalizedString("Cannot parse response. Please, contact support", comment: "cannot_parse_data")
        case .generic(let error):
            let nserror = error as NSError
            return nserror.localizedDescription
        }
    }
    
}
