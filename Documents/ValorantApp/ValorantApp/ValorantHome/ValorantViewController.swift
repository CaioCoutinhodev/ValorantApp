//
//  ViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 23/04/26.
//

import UIKit

class ValorantViewController: UIViewController {
    
    let valorantView = ValorantView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = valorantView
        valorantView.backgroundColor = .black
        ValorantService.shared.fetchUsers(completion: { result in
            print(result)
        })
    }


}

