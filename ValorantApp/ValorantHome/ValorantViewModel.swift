//
//  ValorantViewModel.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 27/04/26.
//

import Foundation

struct ValorantViewModel {
    
    var agents: [AgentModel]
    
    init(model: [AgentModel]) {
        agents = model
    }
    
}
