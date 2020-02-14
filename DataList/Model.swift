//
//  Model.swift
//  DataList
//
//  Created by Masam Mahmood on 14.02.2020.
//  Copyright © 2020 xyz. All rights reserved.
//

import Foundation

struct SectionList : Codable {
    
    let title : String?
    var items : [Item]?
       
}

struct PickListData: Codable {
    let items: [Item]?
}

struct Item : Codable {
    
    let actionType : Int?
    var textField : String?
    var pickList: [SectionList]?
    var selection: [Item]?
    let selectedValue: [String]?
    let version: Int?
    let masterId: Int?
    let itemValue: String?
}
