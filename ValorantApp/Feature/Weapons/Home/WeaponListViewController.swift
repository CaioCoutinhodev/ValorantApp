//
//  HomeWeaponsViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//

import UIKit

class WeaponListViewController: UIViewController{

    var homeWaponsView = SelectListView(title: "Armas")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeWaponsView
        homeWaponsView.favoriteKey = .weapons
        fetchData()
        homeWaponsView.backgroundColor = Utils.AppColors.BackgroundColor
        homeWaponsView.delegate = self
        navigationItem.backButtonTitle = homeWaponsView.title.text
    }
    
    private func fetchData() {
        ValorantService.shared.fetchWeapons { [weak self] result in
            switch result {
            case .success(let weapons):
                
                DispatchQueue.main.async {
                    let viewModel = SelectListViewModel(weapons: weapons)
                    self?.homeWaponsView.viewModel = viewModel
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension WeaponListViewController: SelectListViewDelegate  {
    func favorite(id: String) {
        FavoriteService.changeState(id: id, key: .weapons)
        fetchData()
    }
    
    func didSelectAgent(id: String) {
        let vc = WeaponsPageViewController(id: id)
        navigationController?.pushViewController(vc, animated: true)
 }
}


