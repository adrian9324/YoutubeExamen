//
//  UIImageExtension.swift
//  YouTubeSearch
//
//  Created by Adrián Salazar G on 09/07/18.
//  Copyright © 2018 Adrián Salazar G. All rights reserved.
//

import Foundation

extension UIImageView {
    
    /// Dowloaded from
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - mode: UIViewContentMode
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else { return }
        DispatchQueue.main.async() {
            self.image = image
        }
        }.resume()
    }
    
}

