//
//  HomeWeaponsViewModel.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//

import Foundation

struct WeaponListViewModel {
    
    var weapons: [WeaponModel]
    
    init(model: [WeaponModel]) {
        weapons = model
    }
    
}
