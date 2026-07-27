//
//  FavoriteService.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 02/07/26.
//

import Foundation

enum FavoriteKey: String {
    case characters = "characters"
    case weapons = "weapons"
    case skins = "skins"
}

class FavoriteService {
    
    private static let defaults = UserDefaults.standard
    
    static func favorites(key: FavoriteKey) -> [String] {
        return read(key: key)
    }
    
    private static func read(key: FavoriteKey) -> [String] {
        guard let data = defaults.data(forKey: key.rawValue) else {
            return []
        }
        
        let favorite = decode(data: data)
        return favorite
    }
    
    private static func create(favorites: [String], id: String, key: FavoriteKey) -> [String] {
        var favorites = favorites
        
        favorites.append(id)
        
        let data = encode(favorites: favorites)
        defaults.set(data, forKey: key.rawValue)
        
        return favorites
    }
    
    private static func delete(favorites: [String], id: String, key: FavoriteKey) -> [String] {
        var favorites = favorites
        
        favorites.removeAll { favorite in
            favorite == id
        }
        
        let data = encode(favorites: favorites)
        defaults.set(data, forKey: key.rawValue)
        
        return favorites
    }
    
    static func changeState(id: String, key: FavoriteKey) -> [String] {
        var favorites = read(key: key)
        
        let containID = favorites.contains { favorite in
            return favorite == id
        }
        
        if containID {
            favorites = delete(favorites: favorites, id: id, key: key)
        } else {
            favorites = create(favorites: favorites, id: id, key: key)
        }
        
        return favorites
    }
}

private func encode(favorites: [String]) -> Data {
    let data = try? JSONEncoder().encode(favorites)
    return data!
}

private func decode(data: Data) -> [String] {
    let favorite = try? JSONDecoder().decode([String].self, from: data)
    return favorite!
}
