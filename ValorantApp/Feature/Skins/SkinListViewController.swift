//
//  SkinListViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 08/06/26.
//

import UIKit

class SkinListViewController: UITableViewController {
    
    private var skins: [SkinModel]
    
    var skinView = SelectListView(title: "Skins")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = skinView
        skinView.favoriteKey = .skins
        skinView.backgroundColor = Utils.AppColors.BackgroundColor
        skinView.delegate = self
    }
    
    init(skins: [SkinModel]) {
        self.skins = skins
        super.init(style: .plain)

        skinView.viewModel = SelectListViewModel(skins: skins)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SkinListViewController: SelectListViewDelegate  {
    
    func favorite(id: String) {
        FavoriteService.changeState(id: id, key: .skins)

        skinView.viewModel = SelectListViewModel(skins: skins)
    }
    
    func didSelectAgent(id: String) {
        // TO DO
    }
}
