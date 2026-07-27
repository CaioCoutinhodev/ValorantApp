//
//  MenuButtom.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/06/26.
//

import Foundation
import UIKit

class MenuButtom: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = Utils.AppColors.primaryColor
        self.titleLabel?.font = .systemFont(ofSize: 26)
        self.setTitleColor(.black, for: .normal)
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

