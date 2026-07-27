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
        listItems = agents.map {
            SelectListItem(
                id: $0.uuid,
                icon: $0.displayIcon,
                title: $0.displayName
            )
        }

        canSelectList = true
        sortFavorites(key: .characters)
    }
    
    init(weapons: [WeaponModel]) {
        listItems = weapons.map({ weapons in
            return SelectListItem(id: weapons.uuid,
                                  icon: weapons.displayIcon,
                                  title: weapons.displayName)
        })
        
        canSelectList = true
        sortFavorites(key: .weapons)
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
        sortFavorites(key: .skins)
    }
    mutating func sortFavorites(key: FavoriteKey) {
        let favorites = FavoriteService.favorites(key: key)

        listItems.sort { first, second in
            let firstFavorite = favorites.contains(first.id)
            let secondFavorite = favorites.contains(second.id)

            if firstFavorite == secondFavorite {
                return first.title < second.title
            }

            return firstFavorite
        }
    }
    
}
