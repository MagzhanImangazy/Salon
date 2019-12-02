//
//  DetailModel.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/1/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import Foundation
class DetailModel:Decodable {
    let salon: Salon
    let masters: [Masters]
}
class Salon: Decodable {
    let category: String
    let name: String
    let address: String
    let workStartTime: String
    let workEndTime: String
    let type: String
    let checkRating: Double
    let instagramProfile: String
    let avatarUrl: String
    let reviewCount: Int
    let averageRating: Double
}
class Masters: Decodable {
    let id: Int
    let name: String
    let surname: String
    let profession: String
}
class Location: Decodable {
    let markerX: Double
    let markerY: Double
    let centerX: Double
    let centerY: Double
    let zoom: Int
}
