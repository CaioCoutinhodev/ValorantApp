//
//  WeaponsPageViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 25/05/26.
//

import UIKit

class WeaponsPageViewController: UIViewController {
    
    var weaponPageView = WeaponsPageView()
    var skins: [SkinModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = weaponPageView
        weaponPageView.backgroundColor = Utils.AppColors.BackgroundColor
        weaponPageView.delegate = self
    }
    
    init(id: String) {
        super.init(nibName: nil, bundle: nil)
        fetchAgent(id: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchAgent(id: String) {
        ValorantService.shared.fetchWeapon(weaponID: id) { [weak self] result in
            switch result {
            case .success(let weapon):
                
                DispatchQueue.main.async {
                    self?.skins = weapon.skins
                    
                    let viewModel = WeaponPageViewModel(model: weapon)
                    self?.weaponPageView.viewModel = viewModel
                    self?.navigationItem.backButtonTitle = weapon.displayName
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension WeaponsPageViewController: WeaponsPageViewDelegate {
    func navigationCharterPageView() {
        let vc = SkinListViewController(skins: skins)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
