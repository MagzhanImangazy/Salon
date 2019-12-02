//
//  NetworkService.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/1/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import Foundation
class NetworkService{
    
    public func request(url:String,completion: @escaping (Data?,Error?)->()){
        guard let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request:URLRequest,completion:@escaping (Data?,Error?)->())->URLSessionDataTask{
        
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data,error)
            }
        })
        
    }
    
}
