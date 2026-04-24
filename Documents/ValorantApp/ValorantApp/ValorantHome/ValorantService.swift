//
//  MarvelService.swift
//  ProjectMarvel
//
//  Created by Jonatas Coutinho de Faria on 14/04/26.
//

import Foundation

final class ValorantService {
    
    var characters: [AgentModel] = []
    
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
        
        request(request: urlRequest, completion: { (result: Result<AgentsUnwrapperModel, Error>) in
            switch result {
            case .success(let model):
                completion(.success(model.data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
//    func fetchUser(id: Int, completion: @escaping (Result<CharterModel, Error>) -> Void) {
//        let request = URLRequest(url: <#T##URL#>)
//    }

    func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
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
