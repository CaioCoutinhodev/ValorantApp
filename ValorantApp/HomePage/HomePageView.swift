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
    
    var chartersButtom: UIButton = {
        var butom = UIButton()
        butom.setTitle("Personagens", for: .normal)
        butom.titleLabel?.font = .systemFont(ofSize: 24)
        butom.setTitleColor(.black, for: .normal)
        butom.layer.borderWidth = 1
        butom.translatesAutoresizingMaskIntoConstraints = false
        return butom
    }()
    
    var weaponsButtom: UIButton = {
        var butom = UIButton()
        butom.setTitle("Armas", for: .normal)
        butom.titleLabel?.font = .systemFont(ofSize: 24)
        butom.setTitleColor(.black, for: .normal)
        butom.layer.borderWidth = 1
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
        addSubview(chartersButtom)
        addSubview(weaponsButtom)
        
        NSLayoutConstraint.activate([
            chartersButtom.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            chartersButtom.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            weaponsButtom.topAnchor.constraint(equalTo: chartersButtom.bottomAnchor, constant: 10),
            weaponsButtom.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

        ])
    }

}
