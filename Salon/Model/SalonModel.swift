//
//  SalonModel.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/1/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import Foundation
class SalonModel:Decodable {
    let salons:[Salons]
}
class Salons:Decodable {
    let id: Int
    let name: String
    let type: String
    let checkRating: Int
    let pictureUrl: String
}
