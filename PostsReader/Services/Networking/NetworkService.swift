//
//  NetworkService.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

class NetworkService {
    
    private init() { }
    static let shared = NetworkService()
    
    func getPosts() -> Observable<[PostModel]> {
        let request = NetworkRouter.getPosts
        return performRequest(request, type: [PostModel].self)
    }
    
    func getUser(userId: Int) -> Observable<[UserModel]> {
        let request = NetworkRouter.getUser(userId: userId)
        return performRequest(request, type: [UserModel].self)
    }
    
    func getComments(postId: Int) -> Observable<[CommentModel]> {
        let request = NetworkRouter.getComments(postId: postId)
        return performRequest(request, type: [CommentModel].self)
    }
    
    private func performRequest<T: Decodable>(_ urlRequest: URLRequestConvertible,
                                              type: T.Type) -> Observable<T> {
        
        return RxAlamofire.requestData(urlRequest).map({ [unowned self] _, data in
            return try self.proceedResult(type: type, data: data)
        })
    }
    
    func proceedResult<T: Decodable>(type: T.Type, data: Data?) throws -> T {

        guard let data = data else {
            throw GenericError.cannotParseData
        }
        
        do {
            let response = try JSONDecoder().decode(type, from: data)
            return response
        } catch (let error ) {
            let nserror = error as NSError
            print("Error occurred when trying to parse \(type): \n ***\(nserror.userInfo)***")
            throw GenericError.generic(error)
        }
    }
}

