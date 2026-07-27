//
//  ValorantViewModel.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 27/04/26.
//

import Foundation

struct SelectListItem {
    let id: String
    let icon: String
    let title: String
}

struct SelectListViewModel {
    
    var listItems: [SelectListItem]
    var canSelectList: Bool
    
    init(agents: [AgentModel]) {
        listItems = agents.map({ agent in
            return SelectListItem(id: agent.uuid,
                                  icon: agent.displayIcon,
                                  title: agent.displayName)
            
        })
        
        canSelectList = true
    }
    
    init(weapons: [WeaponModel]) {
        listItems = weapons.map({ weapons in
            return SelectListItem(id: weapons.uuid,
                                  icon: weapons.displayIcon,
                                  title: weapons.displayName)
        })
        
        canSelectList = true
    }
    
    init(skins: [SkinModel]) {
        
        let filteredSkins = skins.filter {
            !$0.displayName.lowercased().contains("padrão")
        }
        
        listItems = filteredSkins.compactMap { skin in
            guard let icon = skin.displayIcon else {
                return nil
            }
            
            return SelectListItem(
                id: skin.uuid,
                icon: icon,
                title: skin.displayName
            )
        }
        
        canSelectList = false
    }
    
}
