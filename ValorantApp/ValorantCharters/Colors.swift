//
//  Colors.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 13/05/26.
//

struct Gradient {
    
    var viewModel: ValorantAgentViewModel?
    var colors: [String]
    
    init(viewModel: ValorantAgentViewModel?) {
        self.viewModel = viewModel
        self.colors = viewModel?.agent.backgroundGradientColors ?? []
    }
    
    
}

