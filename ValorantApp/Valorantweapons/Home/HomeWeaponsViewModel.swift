//
//  HomeWeaponsViewModel.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//

import Foundation

struct HomeWeaponsViewModel {
    
    var weapons: [WeaponsModel]
    
    init(model: [WeaponsModel]) {
        weapons = model
    }
    
}
