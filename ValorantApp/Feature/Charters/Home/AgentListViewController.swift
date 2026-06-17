//
//  ViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 23/04/26.
//

import UIKit

class AgentListViewController: UIViewController {
 
    let valorantView = SelectListView(title: "Personagens")
    
    
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
                        let vm = SelectListViewModel(agents: agents)

                        self?.valorantView.viewModel = vm
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
}
extension AgentListViewController: SelectListViewDelegate{
    func didSelectAgent(id: String){
        let vc = CharterPageViewController(id: id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
