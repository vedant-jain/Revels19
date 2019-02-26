//
//  Model.swift
//  Revels
//
//  Created by Vedant Jain on 23/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import Foundation

struct DataStruct: Decodable {
    let id: Int
    let name: String
    let type: String
    let description: String
    let cc1_name: String
    let cc1_contact: String
    let cc2_name: String
    let cc2_contact: String
    
    init() {
        id = -1
        name = ""
        type = ""
        description = ""
        cc1_name = ""
        cc1_contact = ""
        cc2_name = ""
        cc2_contact = ""
    }
}

struct CategoryContainer: Decodable {
    let success: Bool
    let data: [DataStruct]
    
    init() {
        success = false
        data = [DataStruct.init()]
    }
}

struct EventContainer: Decodable {
    let success: Bool
    let data: [EventStruct]
    
    init() {
        success = false
        data = [EventStruct.init()]
    }
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
    
    init() {
        id = -1
        name = ""
        category = -1
        short_desc = ""
        long_desc = ""
        min_size = -1
        max_size = -1
        del_card_type = -1
    }
}
