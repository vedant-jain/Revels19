//
//  Model.swift
//  Revels
//
//  Created by Vedant Jain on 27/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

struct ResultsContainer: Decodable {
    
    let success: Bool
    let data: [ResultsStruct]
    
}

struct ResultsStruct: Decodable {
    
    let event: Int
    let teamid: Int
    let position: Int
    let round: Int
    
}


// used this to keep track of sections
struct SectionState {

    var isExpanded: Bool
    var eventID: Int
    var count: Int
    var results: [ResultsStruct]
    
}
