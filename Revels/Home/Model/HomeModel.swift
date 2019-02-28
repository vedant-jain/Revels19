//
//  HomeModel.swift
//  Revels
//
//  Created by Naman Jain on 27/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import Foundation

struct userProfileResponse : Decodable {
    let success : Bool
    let data : userData
}

struct userData : Decodable {
    let id : Int
    let name : String?
    let email : String?
    let collname : String?
    let mobile: String?
    let qr: String?
}

struct registeredEventsResponse : Decodable {
    let success : Bool
    let data : [registeredEvent]
}

struct registeredEvent : Decodable {
    let teamid : Int?
    let event : Int?
    let round : Int?
    let delid : Int?
}
