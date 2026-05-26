//
//  CharterPageView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 29/04/26.
//

import UIKit

protocol CharterPageViewDelegate: AnyObject {
    func didSelectAbility(ability: Abilities)
}

class CharterPageView: UIView {
    
    var viewModel: ValorantAgentViewModel? {
        didSet {
            setupData()
        }
    }
    weak var delegate: CharterPageViewDelegate?
    
    struct buttomAbilities {
        var buttom: UIButton
        var lablel: UILabel
        
    }
    
    var backgroundImageAgent: UIView = {
        var background = UIView()
        background.backgroundColor = .black
        background.layer.cornerRadius = 5
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    private var agentImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.alpha = 0.1
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var nameCharter: UILabel = {
        var text = UILabel()
        text.text = text.text
        text.font = UIFont.boldSystemFont(ofSize: 27)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var descriptionCharter: UILabel = {
        var text = UILabel()
        text.text = text.text
        text.font = .systemFont(ofSize: 20)
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var abilities: [Abilities] = []
    
     var stackView: UIStackView = {
        let stack = UIStackView()
         stack.distribution = .fill
         stack.alignment = .fill
         stack.spacing = 17
         stack.axis = .horizontal
         stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
     }()
    
    var textAbilities: UILabel = {
        var text = UILabel()
        text.text = "Habilidades"
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var ability: Abilities?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var customCellView = CustomCellAbility()
    
    func setupData() {
        guard let viewModel = viewModel else {
            return
        }
        
        for i in 0 ..< viewModel.agent.abilities.count {
            let customCellView = CustomCellAbility()
            customCellView.configure(abilityAgent: viewModel.agent.abilities[i])
            stackView.addArrangedSubview(customCellView)
            
            
            
            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(didTapAbility(_:))
            )
            
            configure(abilityAgent: viewModel.agent.abilities[i])
            
            customCellView.addGestureRecognizer(tap)
            

        }
        
        func configure(abilityAgent: Abilities) {

            self.ability = abilityAgent
        }
        
        Utils.configure(imageUrl: viewModel.agent.background, completion: { [weak self] image in
            guard let image = image else {
                return
            }
            self?.backgroundImage.tintColor = .black
            self?.backgroundImage.image = image.withRenderingMode(.alwaysTemplate)
        })
        
        Utils.configure(imageUrl: viewModel.agent.displayIconSmall, completion: { [weak self] image in
            guard let image = image else {
                return
            }
            self?.agentImageView.image = image
        })
    
        nameCharter.text = viewModel.agent.displayName
        descriptionCharter.text = viewModel.agent.description
        abilities = viewModel.agent.abilities
        
        
    }
    @objc func didTapAbility(_ sender: UITapGestureRecognizer) {

        guard let cell = sender.view as? CustomCellAbility,
              let ability = cell.ability else {
            return
        }

        delegate?.didSelectAbility(ability: ability)
    }

    private func setupView() {
        addSubview(backgroundImage)
        sendSubviewToBack(backgroundImage)
        addSubview(backgroundImageAgent)
        addSubview(agentImageView)
        addSubview(nameCharter)
        addSubview(descriptionCharter)
        sendSubviewToBack(agentImageView)
        bringSubviewToFront(agentImageView)
        addSubview(textAbilities)
        addSubview(stackView)
        customCellView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            backgroundImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 980),
            backgroundImage.widthAnchor.constraint(equalToConstant: 450),

            backgroundImageAgent.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backgroundImageAgent.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
            backgroundImageAgent.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15),
            backgroundImageAgent.heightAnchor.constraint(equalToConstant: 220),

            agentImageView.topAnchor.constraint(equalTo: backgroundImageAgent.topAnchor, constant: 8),
            agentImageView.leftAnchor.constraint(equalTo: backgroundImageAgent.leftAnchor, constant: 8),
            agentImageView.rightAnchor.constraint(equalTo: backgroundImageAgent.rightAnchor, constant: -8),
            agentImageView.bottomAnchor.constraint(equalTo: backgroundImageAgent.bottomAnchor, constant: -8),
            

            nameCharter.topAnchor.constraint(equalTo: backgroundImageAgent.bottomAnchor, constant: 19),
            nameCharter.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
            nameCharter.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15),

            descriptionCharter.topAnchor.constraint(equalTo: nameCharter.bottomAnchor, constant: 15),
            descriptionCharter.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
            descriptionCharter.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15),
            
            textAbilities.topAnchor.constraint(equalTo: descriptionCharter.bottomAnchor, constant: 15),
            textAbilities.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
            
            stackView.topAnchor.constraint(equalTo: textAbilities.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }

   
    
}
