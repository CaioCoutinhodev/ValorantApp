
//
//  CharterPageView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 29/04/26.
//

import UIKit

protocol WeaponsPageViewDelegate: AnyObject {
    func didSelectWeapon(weapon: Abilities)
}

class WeaponsPageView: UIView {
    
    var viewModel: WeaponPageViewModel? {
        didSet {
            configuration()
        }
    }
    
    weak var delegate: WeaponsPageViewDelegate?
    
    private var weaponImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var nameWeapon: UILabel = {
        var text = UILabel()
        text.text = text.text
        text.font = UIFont.boldSystemFont(ofSize: 27)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var categoryWeapon: UILabel = {
        var text = UILabel()
        text.text = text.text
        text.font = .systemFont(ofSize: 20)
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        
        Utils.configure(imageUrl: viewModel.weapon.displayIcon, completion: { [weak self] image in
            guard let image = image else {
                return
            }
            self?.weaponImageView.image = image
        })
        
        nameWeapon.text = viewModel.weapon.displayName
        categoryWeapon.text = viewModel.weapon.category
    }

    private func setupView() {
        addSubview(weaponImageView)
        addSubview(nameWeapon)
        addSubview(categoryWeapon)
        
        
        NSLayoutConstraint.activate([

            weaponImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            weaponImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            weaponImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            weaponImageView.heightAnchor.constraint(equalToConstant: 80),
            

            nameWeapon.topAnchor.constraint(equalTo: weaponImageView.bottomAnchor, constant: 19),
            nameWeapon.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
            nameWeapon.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15),

            categoryWeapon.topAnchor.constraint(equalTo: nameWeapon.bottomAnchor, constant: 15),
            categoryWeapon.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
            categoryWeapon.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }

   
    
}
