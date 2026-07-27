//
//  ValorantAgentViewModel.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 05/05/26.
//

import Foundation

struct CharacterPageViewModel {
    
    var agent: CompleteAgentModel
    
    init(model: CompleteAgentModel) {
        agent = model
    }
}
