//
//  HomeWeaponsViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//

import UIKit

class HomeWeaponsViewController: UIViewController {

    var homeWraponsView = HomeWeaponsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeWraponsView
        fetchData()
        homeWraponsView.backgroundColor = .white
        homeWraponsView.delegate = self
    }
    
    private func fetchData() {
        WeaponsService.shared.fetchUsers { [weak self] result in
            switch result {
            case .success(let weapons):
                
                DispatchQueue.main.async {
                    let viewModel = HomeWeaponsViewModel(model: weapons)
                    self?.homeWraponsView.viewModel = viewModel
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension HomeWeaponsViewController: HomeWeaponsViewDelegate {
    func didSelectWeapons(id: String) {
                let vc = WeaponsPageViewController(id: id)
                navigationController?.pushViewController(vc, animated: true)
        }
    }
