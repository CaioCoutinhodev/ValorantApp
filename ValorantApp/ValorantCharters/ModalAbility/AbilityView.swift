//
//  AbilityView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 18/05/26.
//

import Foundation
import UIKit


class AbilityView: UIViewController {
    
    var viewModel: ModalViewModel
    
    init(viewModel: ModalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            configuration()
            setupUI()
        backButtom.addTarget(
            self,
            action: #selector(closeModal),
            for: .touchUpInside
        )
        }
    
    var backButtom: UIButton = {
        var butom = UIButton()
        butom.setTitle("X", for: .normal)
        butom.titleLabel?.font = .systemFont(ofSize: 24)
        butom.setTitleColor(.black, for: .normal)
        butom.translatesAutoresizingMaskIntoConstraints = false
        return butom
    }()
    
    var nameAbility: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionAbility: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageAbility: UIImageView = {
        var image = UIImageView()
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    @objc func closeModal() {
        dismiss(animated: true)
    }
    
    private func configuration() {
        Utils.configure(
            imageUrl: viewModel.ability.displayIcon,
            completion: { [weak self] image in

                guard let image = image else {
                    return
                }

                self?.imageAbility.image = image.withTintColor(.black, renderingMode: .alwaysOriginal)
            }
        )
        self.nameAbility.text = viewModel.ability.displayName
        self.descriptionAbility.text = viewModel.ability.description
    }
            
    private func setupUI() {

            view.addSubview(backButtom)
            view.addSubview(imageAbility)
            view.addSubview(nameAbility)
            view.addSubview(descriptionAbility)

        
            NSLayoutConstraint.activate([
                
                backButtom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                backButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

                imageAbility.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                imageAbility.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageAbility.widthAnchor.constraint(equalToConstant: 100),
                imageAbility.heightAnchor.constraint(equalToConstant: 100),

                nameAbility.topAnchor.constraint(equalTo: imageAbility.bottomAnchor, constant: 20),
                nameAbility.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                descriptionAbility.topAnchor.constraint(equalTo: nameAbility.bottomAnchor, constant: 20),
                descriptionAbility.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                descriptionAbility.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)

            ])
        }
    }
