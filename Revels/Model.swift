//
//  Model.swift
//  Revels
//
//  Created by Naman Jain on 31/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import Foundation
import UIKit

struct CategoriesResponse : Decodable {
    let success : Bool
    let data : [Categories]?
}

struct Categories : Decodable {
    let id : Int?
    let name : String?
    let description : String?
    let cc1_name : String?
    let cc1_contact : String?
    let cc2_name : String?
    let cc2_contact : String?
}

struct Tutorial : Decodable {
    let tutorialId : String?
    let name : String?
    let description : String?
    let domain : String?
    let author : String?
    var content : String?
}

struct ScheduleEvent{
    let event: Event?
    let eventTime: String?
    let eventVenue: String?
    let eventRound: Int
    
    init(event: Event, time: String, venue: String, round: Int) {
        self.event = event
        self.eventTime = time
        self.eventVenue = venue
        self.eventRound = round
    }
    
    func returnName() -> String{
        if let name = event?.name{
            return name
        }
        return "event n/a"
    }
}

struct EventResponse : Decodable {
    let success: Bool
    let data: [Event]?
}

struct Event : Decodable {
    let id: Int
    let category: Int
    let name: String?
    let short_desc: String?
    let long_desc: String?
    let min_size: Int?
    let max_size: Int?
    let del_card_type: Int?
}

struct ScheduleResponse : Decodable {
    let success: Bool
    let data: [Schedule]?
}

struct Schedule : Decodable {
    let event: Int
    let round: Int?
    let start: String?
    let end: String?
    let location: String?
}

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
