//
//  CustomCell.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 27/04/26.
//

import Foundation
import UIKit

final class CustomCell: UITableViewCell {

    static let identifier = "AgentCell"

    private let agentImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(agentImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            agentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            agentImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            agentImageView.widthAnchor.constraint(equalToConstant: 60),
            agentImageView.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.leadingAnchor.constraint(equalTo: agentImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        agentImageView.image = nil
    }

    func configure(name: String, imageUrl: String?) {
        nameLabel.text = name

        guard let urlString = imageUrl,
              let url = URL(string: urlString) else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {

                DispatchQueue.main.async {
                    self.agentImageView.image = image
                }
            }
        }
    }
}

