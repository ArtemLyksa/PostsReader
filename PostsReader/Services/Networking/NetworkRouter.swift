//
//  NetworkRouter.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkRouter: URLRequestConvertible {
    
    private static let baseUrl = URL(string: "http://jsonplaceholder.typicode.com")!
    
    case getPosts
    case getUser(userId: Int)
    case getComments(postId: Int)
    
    func asURLRequest() throws -> URLRequest {
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getPosts, .getUser, .getComments:
                return .get
            }
        }
        
        var url: URL {
            switch self {
            case .getPosts:
                return NetworkRouter.baseUrl.appendingPathComponent("posts")
            case .getUser:
                return NetworkRouter.baseUrl.appendingPathComponent("users")
            case .getComments:
                return NetworkRouter.baseUrl.appendingPathComponent("comments")
            }
        }
        
        var params: Parameters? {
            switch self {
            case .getPosts:
                return nil
            case .getUser(let userId):
                return ["userId": userId]
            case .getComments(let postId):
                return ["postId": postId]
            }
        }
        
        let encoding = URLEncoding.queryString
        let request = try URLRequest(url: url, method: httpMethod)
        
        return try encoding.encode(request, with: params)
    }
    
}
