//
//  SkinListViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 08/06/26.
//

import UIKit

class SkinListViewController: UITableViewController {
    
    var skinView = SelectListView(title: "Skins")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = skinView
        
        skinView.backgroundColor = .white
        skinView.delegate = self
    }
    
    init(skins: [SkinModel]) {
        super.init(style: .plain)
       
        let viewModel = SelectListViewModel(skins: skins)
        skinView.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SkinListViewController: SelectListViewDelegate  {
    func didSelectAgent(id: String) {
        // TO DO
    }
}
