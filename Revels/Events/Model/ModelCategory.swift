//
//  Model.swift
//  Revels
//
//  Created by Vedant Jain on 23/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import Foundation

struct CategoryStruct: Decodable {
    let id: Int
    let name: String
    let type: String
    let description: String
    let cc1_name: String
    let cc1_contact: String
    let cc2_name: String
    let cc2_contact: String
}

struct EventStruct: Decodable {
    let id: Int
    let category: Int
    let name: String
    let short_desc: String
    let long_desc: String
    let min_size: Int
    let max_size: Int
    let del_card_type: Int
}

//only for parsing; not used anywhere in code
struct CategoryContainer: Decodable {
    let success: Bool
    let data: [CategoryStruct]
}

struct EventContainer: Decodable {
    let success: Bool
    let data: [EventStruct]
}
