//
//  ViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 23/04/26.
//

import UIKit

class HomeListAgentsViewController: UIViewController {
 
    let valorantView = HomeListAgentsView(title: "Personagens")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = valorantView
        valorantView.backgroundColor = .white
        fetchData()
        valorantView.delegate = self
        navigationItem.backButtonTitle = "Voltar"
}

        private func fetchData() {
            ValorantService.shared.fetchUsers { [weak self] result in
                switch result {
                case .success(let agents):
                    
                    DispatchQueue.main.async {
                        let viewModel = ValorantAgentsViewModel(model: agents)
                        self?.valorantView.viewModel = viewModel
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
}
extension HomeListAgentsViewController: HomeListAgentsViewDelegate{
    func didSelectAgent(id: String){
        let vc = CharterPageViewController(id: id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
