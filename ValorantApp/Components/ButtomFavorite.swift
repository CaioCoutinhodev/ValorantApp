//
//  ButtomFavorite.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 14/07/26.
//
import UIKit
import Foundation

class ButtomFavorite: UIButton {
    private var isFavorite: Bool
    
    
    init(state: Bool) {
        self.isFavorite = state
        super.init(frame: .zero)
        tintColor = .systemYellow
        imageView?.contentMode = .scaleAspectFit
        updateImage()
    }
    
    private func updateImage() {
        let imageName = isFavorite ? "star.fill" : "star"
        setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
        updateImage()
    }

    func setFavorite(_ favorite: Bool) {
        isFavorite = favorite
        updateImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


