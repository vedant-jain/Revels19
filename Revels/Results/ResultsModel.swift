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
