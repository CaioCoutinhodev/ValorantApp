//
//  Utils.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 06/05/26.
//

import Foundation
import UIKit

class Utils {
    
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
