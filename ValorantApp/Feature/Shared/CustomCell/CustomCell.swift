//
//  CustomCell.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 27/04/26.
//

import Foundation
import UIKit

protocol CustomCellDelegate: AnyObject {
    func didTapFavorite(in cell: CustomCell)
}

final class CustomCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?
    
    static let identifier = "Cell"
    
    private let agentImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var buttomFavorite: ButtomFavorite = {
        let buttom = ButtomFavorite(state: false)
        buttom.translatesAutoresizingMaskIntoConstraints = false
        return buttom
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buttomFavorite.addTarget(
            self,
            action: #selector(didTapFavorite),
            for: .touchUpInside
        )
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapFavorite() {
        delegate?.didTapFavorite(in: self)
    }
    
    private func setupUI() {
        contentView.addSubview(agentImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(buttomFavorite)
        
        
        NSLayoutConstraint.activate([
            agentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            agentImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            agentImageView.widthAnchor.constraint(equalToConstant: 60),
            agentImageView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.leadingAnchor.constraint(equalTo: agentImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            buttomFavorite.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            buttomFavorite.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            buttomFavorite.heightAnchor.constraint(equalToConstant: 40),
            buttomFavorite.widthAnchor.constraint(equalToConstant: 40)
            
            
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        agentImageView.image = nil
    }
    
    func configure(name: String, imageUrl: String?, isFavorite: Bool) {
        nameLabel.text = name
        
        buttomFavorite.setFavorite(isFavorite)
        
        Utils.configure(imageUrl: imageUrl) { [weak self] image in
            guard let image = image else {
                return
            }
            
            self?.agentImageView.image = image
        }
    }
}

