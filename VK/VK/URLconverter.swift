//
//  URLconverter.swift
//  VK
//
//  Created by пользовтель on 08.05.2021.
//

import UIKit

func convertUrlToImage (url: URL) -> UIImage? {
    
    let data = try? Data(contentsOf: url)
    
    if let imageData = data {
        guard let image = UIImage(data: imageData) else { return nil }
        return image
    }
    return nil
}
