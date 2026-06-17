
//
//  CharterPageView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 29/04/26.
//

import UIKit

protocol WeaponsPageViewDelegate: AnyObject {
    func navigationCharterPageView()
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
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var skins: [SkinModel] = []
    
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
    
    var buttomSkins: UIButton = {
        var butom = UIButton()
        butom.setTitle("Skins", for: .normal)
        butom.backgroundColor = UIColor(
            red: 255.0 / 255.0,
            green: 70.0 / 255.0,
            blue: 84.0 / 255.0,
            alpha: 1.0
        )
        butom.titleLabel?.font = .systemFont(ofSize: 24)
        butom.setTitleColor(.black, for: .normal)
        butom.layer.borderWidth = 1
        butom.translatesAutoresizingMaskIntoConstraints = false
        return butom
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        buttomSkins.addTarget(self, action: #selector(didTapButtonSkins), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButtonSkins() {
        delegate?.navigationCharterPageView()
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
            .replacingOccurrences(of: "EEquippableCategory::", with: "")
        skins = viewModel.weapon.skins
        print(skins)
        print(skins.count)
    }

    private func setupView() {
        
        addSubview(weaponImageView)
        addSubview(nameWeapon)
        addSubview(categoryWeapon)
        addSubview(buttomSkins)
       
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
            categoryWeapon.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15),
            
            buttomSkins.topAnchor.constraint(equalTo: categoryWeapon.bottomAnchor, constant: 15),
            buttomSkins.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
            buttomSkins.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }

   
    
}
