//
//  WeaponsPageViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 25/05/26.
//

import UIKit

class WeaponsPageViewController: UIViewController {

    var weaponPageView = WeaponsPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = weaponPageView
        weaponPageView.backgroundColor = .white
        
    }
    
    init(id: String) {
        super.init(nibName: nil, bundle: nil)
        fetchAgent(id: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchAgent(id: String) {
        WeaponsService.shared.fetchUser(weaponID: id) { [weak self] result in
            switch result {
            case .success(let weapon):
                
                DispatchQueue.main.async {
                    let viewModel = WeaponPageViewModel(model: weapon)
                    self?.weaponPageView.viewModel = viewModel

                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
