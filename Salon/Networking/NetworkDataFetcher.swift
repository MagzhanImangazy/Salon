//
//  NetworkDataFetcher.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/1/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import Foundation
class NetworkDataFetcher{
    
    var networkService = NetworkService()
    
    init(networkService:NetworkService = NetworkService()){
        self.networkService = networkService
    }
    
    
    func fetchData(urlString:String,completion: @escaping (SalonModel?)->()){
        networkService.request(url: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let result = try? decoder.decode(SalonModel.self, from: data)
            completion(result)
        }
    }
    func fetchDetailData(urlString:String,completion: @escaping (Salon?)->()) {
        networkService.request(url: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let result = try? decoder.decode(Salon.self, from: data, keyPath: "salon")
            completion(result)
        }
    }
    func fetchPhotos(urlString:String,completion: @escaping (String?)->()) {
        networkService.request(url: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let result = try? decoder.decode(String.self, from: data, keyPath: "salon.pictures")
            completion(result)
        }
    }
    func fetchMastersData(urlString:String,completion: @escaping (DetailModel?)->()) {
        networkService.request(url: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let result = try? decoder.decode(DetailModel.self, from: data)
            completion(result)
        }
}
    func fetchLocation(urlString:String,completion: @escaping (Location?)->()) {
        networkService.request(url: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let result = try? decoder.decode(Location.self, from: data,keyPath: "location")
            completion(result)
        }
    }
    
}
