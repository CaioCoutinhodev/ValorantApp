//
//  ViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 23/04/26.
//

import UIKit

class HomeListAgentsViewController: UIViewController {
 
    let valorantView = HomeListAgentsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = valorantView
        valorantView.backgroundColor = .white
        fetchData()
}

        private func fetchData() {
            ValorantService.shared.fetchUsers { [weak self] result in
                switch result {
                case .success(let agents):
                    
                    DispatchQueue.main.async {
                        let viewModel = ValorantViewModel(model: agents)
                        self?.valorantView.viewModel = viewModel
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
}
