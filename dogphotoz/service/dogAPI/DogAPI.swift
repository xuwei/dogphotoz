//
//  DogAPI.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import PromiseKit

class DogAPI {
    
    static let shared = DogAPI()
    private init() { }
    
    let listLimit = 100
    let httpsProtocol: String = "https"
    let domain: String = "api.thedogapi.com"
    let urlPath: String = "/v1/images/search"
    let session: URLSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func photoList(_ limit: Int)-> Promise<[DogPhoto]> {
        return Promise<[DogPhoto]>() { resolver in
            guard let url: URL = generatePhotoListURL(limit) else { resolver.reject(DogAPIError.invalidParams); return }
            dataTask = session.dataTask(with: url) { [weak self] data, response, err in
                
                // clean up task afterward
                defer {
                    self?.dataTask = nil
                }
                
                if err != nil {
                    resolver.reject(DogAPIError.genericError); return
                } else {
                    guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == SuccessHTTPStatusCode else { resolver.reject(DogAPIError.genericError); return
                    }
                    
                    let dogPhotoListDecoder = JSONDecoder()
                    do {
                        let dogPhotoList: [DogPhoto] = try dogPhotoListDecoder.decode(Array<DogPhoto>.self, from: data)
                        resolver.fulfill(dogPhotoList)
                    } catch {
                        resolver.reject(DogAPIError.genericError)
                    }
                }
                
            }
            dataTask?.resume()
        }
    }
    
    func generatePhotoListURL (_ limit: Int)-> URL? {
       guard limit > 0 && limit <= listLimit else { return nil }
       var urlComponent = URLComponents()
       urlComponent.scheme = httpsProtocol
       urlComponent.host = domain
       urlComponent.path = urlPath
        
       urlComponent.queryItems = [
            URLQueryItem(name: "limit", value: String(limit))
       ]
        
       return urlComponent.url
    }
}
