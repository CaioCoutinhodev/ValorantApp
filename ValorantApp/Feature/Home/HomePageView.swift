//
//  HomePageView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//

import UIKit

protocol HomePageViewDelegate: AnyObject {
    func navigationCharacterPageView()
    func navigationWeaponsPageView()
}

class HomePageView: UIView {
    

    weak var delegate: HomePageViewDelegate?
    
    var titleHome: UILabel = {
        var text = UILabel()
        text.text = "Valorant App"
        text.font = UIFont(name: "VALORANT-Regular", size: 40)
        text.textColor = Utils.AppColors.primaryColor
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var charactersButtom: MenuButtom = {
        var button = MenuButtom()
        button.setTitle("Personagens", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var weaponsButtom: MenuButtom = {
        var button = MenuButtom()
        button.setTitle("Armas", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        charactersButtom.addTarget(self, action:#selector(didTapButtonCharacter) , for: .touchUpInside)
        weaponsButtom.addTarget(self, action: #selector(didTapButtonWeapons), for: .touchUpInside)
    }
    
    @objc func didTapButtonCharacter() {

        delegate?.navigationCharacterPageView()
    }
    
    @objc func didTapButtonWeapons() {
        delegate?.navigationWeaponsPageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleHome)
        addSubview(charactersButtom)
        addSubview(weaponsButtom)
        
        NSLayoutConstraint.activate([
            
            titleHome.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            titleHome.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            charactersButtom.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            charactersButtom.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            charactersButtom.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
           
            
            weaponsButtom.topAnchor.constraint(equalTo: charactersButtom.bottomAnchor, constant: 20),
            weaponsButtom.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            weaponsButtom.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),

        ])
    }

}
