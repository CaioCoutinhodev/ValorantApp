//
//  HomePageViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//

import UIKit

class HomePageViewController: UIViewController {

    var homePageView = HomePageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homePageView
        homePageView.backgroundColor = .white
        homePageView.delegate = self
        navigationItem.backButtonTitle = "Voltar"
        
    }
    

}
extension HomePageViewController: HomePageViewDelegate {
    func navigationWeaponsPageView() {
        let vc = HomeWeaponsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
     func navigationCharterPageView() {
        let vc = HomeListAgentsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

