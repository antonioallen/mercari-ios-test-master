//
//  Product.swift
//  Mercari
//
//  Created by Antonio Allen on 7/13/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import Foundation
import Mapper

class Product: Mappable {
    let id: String
    let name:String
    let status:Status
    let likes:Int
    let comments:Int
    let price:Int
    let photoURL: String
    
    // Implement this initializer
    required init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try status = map.from("status")
        try price = map.from("price")
        try photoURL = map.from("photo")
        likes = map.optionalFrom("num_likes") ?? 0
        comments = map.optionalFrom("num_comments") ?? 0
    }
}

enum Status: String {
    case onSale = "on_sale"
    case soldOut = "sold_out"
}
