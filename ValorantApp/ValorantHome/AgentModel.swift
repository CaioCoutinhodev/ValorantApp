//
//  CharterModel.swift
//  ProjectMarvel
//
//  Created by Jonatas Coutinho de Faria on 13/04/26.
//

import Foundation

struct AgentsUnwrapperModel: Codable{
    var data: [AgentModel]
}

struct AgentModel: Codable{
    var uuid: String
    var displayName: String
    var description: String
    var displayIcon: String
   
    init(uuid: String, displayName: String, description: String, displayIcon: String) {
        self.uuid = uuid
        self.displayName = displayName
        self.description = description
        self.displayIcon = displayIcon
    }
}
