//
//  NetworkService.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    private init() { }
    static let shared = NetworkService()
    
    func getPosts(_ completion: @escaping GetPostsCompletion) {
        let request = NetworkRouter.getPosts
        performRequest(request, completion: { [weak self] error, data in
            guard let self = self else {
                completion(NetworkServiceResult.failure(error: GenericError.cannotParseData))
                return
            }
            let result = self.proceedResult(type: [PostModel].self, error: error, data: data)
            completion(result)
        })
    }
    
    private func performRequest(_ urlRequest: URLRequestConvertible,
                                completion: @escaping (GenericError?, Data?) -> Void) {
        Alamofire.request(urlRequest).responseData(completionHandler: { response in
            if let error = response.error {
                completion(GenericError.generic(error), nil)
                return
            }
            guard let data = response.data else {
                completion(GenericError.cannotParseData, nil)
                return
            }
            
            completion(nil, data)
        })
    }
    
    func proceedResult<T: Decodable>(type: T.Type, error: GenericError?, data: Data?) -> NetworkServiceResult<T> {
        if let error = error {
            return NetworkServiceResult.failure(error: error)
        }
        guard let data = data else { return NetworkServiceResult.failure(error: GenericError.cannotParseData) }
        
        do {
            let response = try JSONDecoder().decode(type, from: data)
            return NetworkServiceResult.success(result: response)
        } catch (let error ) {
            let nserror = error as NSError
            print("Error occurred when trying to parse \(type): \n ***\(nserror.userInfo)***")
            return NetworkServiceResult.failure(error: GenericError.cannotParseData)
        }
    }
    
}

extension NetworkService {
    typealias GetPostsCompletion = (_ result: NetworkServiceResult<[PostModel]>) -> Void
    
    enum NetworkServiceResult<U> {
        case success(result: U)
        case failure(error: Error)
    }
}
