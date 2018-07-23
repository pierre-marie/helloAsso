//
//  UIImageViewExtension.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func setImageFromUrl(urlString: String, rounded: Bool) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error.debugDescription)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                if (rounded) {
                    self.layer.masksToBounds = true
                    self.layer.cornerRadius = self.frame.size.width / 2
                }
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
    
}

