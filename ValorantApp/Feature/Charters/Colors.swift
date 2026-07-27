//
//  Colors.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 13/05/26.
//

struct Gradient {
    
    var viewModel: CharterPageViewModel?
    var colors: [String]
    
    init(viewModel: CharterPageViewModel?) {
        self.viewModel = viewModel
        self.colors = viewModel?.agent.backgroundGradientColors ?? []
    }
    
    
}

