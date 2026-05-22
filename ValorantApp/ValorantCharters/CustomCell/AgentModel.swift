//
//  CharterModel.swift
//  ProjectMarvel
//
//  Created by Jonatas Coutinho de Faria on 13/04/26.
//

import Foundation

struct UnwrapperModel<T: Decodable>: Decodable{
    var data: T
}

struct AgentModel: Decodable {
    var uuid: String
    var displayName: String
    var displayIcon: String
   
    init(uuid: String, displayName: String, displayIcon: String) {
        self.uuid = uuid
        self.displayName = displayName
        self.displayIcon = displayIcon
    }
}
struct Abilities: Decodable {
    let slot: String
    let displayName: String
    let description: String
    let displayIcon: String?
}

struct CompleteAgentModel: Decodable {
    var uuid: String
    var displayName: String
    var description: String
    var displayIconSmall: String
    var background: String
    var backgroundGradientColors: [String]
    var abilities: [Abilities]
    
   
    
    init(uuid: String, displayName: String, description: String, fullPortrait: String, background: String, backgroundGradientColors: [String], abilities: [Abilities]) {
        self.uuid = uuid
        self.displayName = displayName
        self.description = description
        self.displayIconSmall = fullPortrait
        self.background = background
        self.backgroundGradientColors = backgroundGradientColors
        self.abilities = abilities
    }
}

