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

struct WeaponModel: Decodable {
    var uuid: String
    var displayName: String
    var displayIcon: String
    
    init(uuid: String, displayName: String, displayIcon: String) {
        self.uuid = uuid
        self.displayName = displayName
        self.displayIcon = displayIcon
    }
}

struct CompleteWeaponsModel: Decodable {
    var displayName: String
    var category: String
    var displayIcon: String
    var skins: [SkinModel]
    
    init(displayName: String, category: String, displayIcon: String, skins: [SkinModel]) {
        self.displayName = displayName
        self.category = category
        self.displayIcon = displayIcon
        self.skins = skins
    }
}

struct SkinModel: Decodable {
    var uuid: String
    var displayName: String
    var displayIcon: String?
    
    init(uuid: String, displayName: String, displayIcon: String) {
        self.uuid = uuid
        self.displayName = displayName
        self.displayIcon = displayIcon
    }
}
