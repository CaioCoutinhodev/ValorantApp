//
//  MarvelService.swift
//  ProjectMarvel
//
//  Created by Jonatas Coutinho de Faria on 14/04/26.
//

import Foundation

final class ValorantService {
    
    var characters: [AgentModel] = []
    var weapons: [WeaponModel] = []
    
    static let shared = ValorantService()

    private init() {}
 
    func fetchUsers(completion: @escaping (Result<[AgentModel], Error>) -> Void) {
        var components = URLComponents(string: "https://valorant-api.com/v1/agents")

        components?.queryItems = [
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "isPlayableCharacter", value: "true")
        ]
        
        guard let url = components?.url else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(request: urlRequest, completion: { (result: Result<UnwrapperModel<[AgentModel]>, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchAgent(agentID: String, completion: @escaping (Result<CompleteAgentModel, Error>) -> Void) {
        var components = URLComponents(string: "https://valorant-api.com/v1/agents/\(agentID)")

        components?.queryItems = [
            URLQueryItem(name: "language", value: "pt-BR")
        ]
        
        guard let url = components?.url else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(request: urlRequest, completion: { (result: Result<UnwrapperModel<CompleteAgentModel>, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func fetchWeapons(completion: @escaping (Result<[WeaponModel], Error>) -> Void) {
        var components = URLComponents(string: "https://valorant-api.com/v1/weapons")

        components?.queryItems = [
            URLQueryItem(name: "language", value: "pt-BR")
        ]
        
        guard let url = components?.url else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(request: urlRequest, completion: { (result: Result<Unwrapper<[WeaponModel]>, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchWeapon(weaponID: String, completion: @escaping (Result<CompleteWeaponsModel, Error>) -> Void) {
        var components = URLComponents(string: "https://valorant-api.com/v1/weapons/\(weaponID)")

        components?.queryItems = [
            URLQueryItem(name: "language", value: "pt-BR")
        ]
        
        guard let url = components?.url else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        request(request: urlRequest, completion: { (result: Result<Unwrapper<CompleteWeaponsModel>, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }


    private func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let e {
                completion(.failure(e))
            }
            
        }.resume()
    }
    
}
