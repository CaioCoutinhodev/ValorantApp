//
//  CustomAbility.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 12/05/26.
//

import Foundation
import UIKit

class CustomCellAbility: UIView {
    
    var imageAbility: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var ability: Abilities?
    
    var nameAbility: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        setupUI()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(abilityAgent: Abilities) {
        self.ability = abilityAgent
        
        let abilityAgent: Abilities = abilityAgent
        Utils.configure(imageUrl: abilityAgent.displayIcon, completion: { [weak self] image in
            guard let image = image else {
                return
            }
            self?.imageAbility.image = image.withRenderingMode(.alwaysTemplate)
            self?.imageAbility.tintColor = .black
        })
        nameAbility.text = abilityAgent.displayName
    }
    
    private func setupUI() {
        
        addSubview(imageAbility)
        addSubview(nameAbility)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            imageAbility.topAnchor.constraint(equalTo: topAnchor),
            imageAbility.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageAbility.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageAbility.heightAnchor.constraint(equalToConstant: 80),
            imageAbility.widthAnchor.constraint(equalToConstant: 80),

            nameAbility.topAnchor.constraint(equalTo: imageAbility.bottomAnchor, constant: 8),
            nameAbility.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameAbility.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameAbility.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }

}
