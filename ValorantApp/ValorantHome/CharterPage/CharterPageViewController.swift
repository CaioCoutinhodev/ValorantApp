//
//  CharterPageViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 29/04/26.
//

import UIKit

class CharterPageViewController: UIViewController {

    var charterPageView = CharterPageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = charterPageView
       
    }
    
    private func fetchData() {
        ValorantService.shared.fetchUsers { [weak self] result in
            switch result {
            case .success(let agents):
                
                DispatchQueue.main.async {
                    let viewModel = ValorantViewModel(model: agents)
                    self?.charterPageView.viewModel = viewModel
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }



}
