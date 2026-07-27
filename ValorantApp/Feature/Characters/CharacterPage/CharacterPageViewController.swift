//
//  CharacterPageViewController.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 29/04/26.
//

import UIKit

class CharacterPageViewController: UIViewController {
    
    
    
    var characterPageView = CharacterPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = characterPageView
        characterPageView.backgroundColor = Utils.AppColors.BackgroundColor
        characterPageView.delegate = self
        
    }
    
    
    init(id: String) {
        super.init(nibName: nil, bundle: nil)
        fetchAgent(id: id)
    }
    
    func fetchAgent(id: String) {
        ValorantService.shared.fetchAgent(agentID: id) { [weak self] result in
            switch result {
            case .success(let agent):
                
                DispatchQueue.main.async {
                    let viewModel = CharacterPageViewModel(model: agent)
                    self?.characterPageView.viewModel = viewModel
                    self?.navigationItem.backButtonTitle = agent.displayName
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
extension CharacterPageViewController : CharacterPageViewDelegate {
    func didSelectAbility(ability: AbilitiesModel) {
        var viewModel = ModalAbilityViewModel(model: ability)
        let abilityViewController = ModalAbilityView(viewModel: viewModel)
        
        
        
            if let modal = abilityViewController.sheetPresentationController {
                modal.detents = [.medium()]
            }

            present(abilityViewController, animated: true)
    }
}
