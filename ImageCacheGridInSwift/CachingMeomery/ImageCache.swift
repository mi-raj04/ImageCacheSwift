//
//  ImageCache.swift
//  ImageCacherGrid
//
//  Created by mind on 15/04/24.
//

import UIKit

class ImageDownloader: NSObject{
    
    static let shared = ImageDownloader()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    func loadImageUsingCache(withUrl urlString : String,completion:@escaping ((UIImage) -> ())) {
        let url = URL(string: urlString)
        if url == nil {return}
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                }
            }
            
        }).resume()
    }
}

