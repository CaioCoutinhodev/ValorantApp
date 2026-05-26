//
//  WeaponsModel.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//

import Foundation

struct Unwrapper<T: Decodable>: Decodable{
    var data: T
}

struct WeaponsModel: Decodable {
    var uuid: String
    var displayName: String
    var category: String
    var displayIcon: String
    
    init(uuid: String, displayName: String, category: String, displayIcon: String) {
        self.uuid = uuid
        self.displayName = displayName
        self.category = category
        self.displayIcon = displayIcon
    }
}
    
    struct CompleteWeaponsModel: Decodable {
        var uuid: String
        var displayName: String
        var category: String
        var displayIcon: String
        
        
        init(uuid: String, displayName: String, category: String, displayIcon: String) {
            self.uuid = uuid
            self.displayName = displayName
            self.category = category
            self.displayIcon = displayIcon
        }
    }

