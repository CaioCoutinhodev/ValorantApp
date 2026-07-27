//
//  Utils.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 06/05/26.
//

import Foundation
import UIKit

class Utils {
    
    struct AppColors {
        static var colorAbility: UIColor {
                guard let color = UIColor(named: "AbilityColor") else {
                    fatalError("Cor 'colorAbility' não encontrada")
                }
                return color
            }
        
        static var primaryColor: UIColor {
                guard let color = UIColor(named: "PrimaryColor") else {
                    fatalError("Cor 'primaryColor' não encontrada")
                }
                return color
            }
        
        static var BackgroundColor: UIColor {
                guard let color = UIColor(named: "BackgroundColor") else {
                    fatalError("Cor 'BackgroundColor' não encontrada")
                }
                return color
            }
    }
    
    static func configure( imageUrl: String?, completion: @escaping (UIImage?) -> Void) {

        guard let urlString = imageUrl,
              let url = URL(string: urlString) else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {

                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }
}
