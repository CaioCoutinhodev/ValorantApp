//
//  HomePageView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//

import UIKit

protocol HomePageViewDelegate: AnyObject {
    func navigationCharterPageView()
    func navigationWeaponsPageView()
}

class HomePageView: UIView {
    

    weak var delegate: HomePageViewDelegate?
    
    var titleHome: UILabel = {
        var text = UILabel()
        text.text = "Valorant App"
        text.font = UIFont.boldSystemFont(ofSize: 30)
        text.textColor = Utils.AppColors.colorRed
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var chartersButtom: UIButton = {
        var butom = UIButton()
        butom.setTitle("Personagens", for: .normal)
        butom.backgroundColor = Utils.AppColors.colorRed
        butom.titleLabel?.font = .systemFont(ofSize: 26)
        butom.setTitleColor(.black, for: .normal)
        butom.layer.borderWidth = 1
        butom.layer.cornerRadius = 12
        butom.translatesAutoresizingMaskIntoConstraints = false
        return butom
    }()
    
    var weaponsButtom: UIButton = {
        var butom = UIButton()
        butom.setTitle("Armas", for: .normal)
        butom.titleLabel?.font = .systemFont(ofSize: 26)
        butom.backgroundColor = Utils.AppColors.colorRed
        butom.setTitleColor(.black, for: .normal)
        butom.layer.borderWidth = 1
        butom.layer.cornerRadius = 12
        butom.translatesAutoresizingMaskIntoConstraints = false
        return butom
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        chartersButtom.addTarget(self, action:#selector(didTapButtonCharter) , for: .touchUpInside)
        weaponsButtom.addTarget(self, action: #selector(didTapButtonWeapons), for: .touchUpInside)
    }
    
    @objc func didTapButtonCharter() {

        delegate?.navigationCharterPageView()
    }
    
    @objc func didTapButtonWeapons() {
        delegate?.navigationWeaponsPageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleHome)
        addSubview(chartersButtom)
        addSubview(weaponsButtom)
        
        NSLayoutConstraint.activate([
            
            titleHome.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            titleHome.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            chartersButtom.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            chartersButtom.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            chartersButtom.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
           
            
            weaponsButtom.topAnchor.constraint(equalTo: chartersButtom.bottomAnchor, constant: 20),
            weaponsButtom.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            weaponsButtom.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),

        ])
    }

}
