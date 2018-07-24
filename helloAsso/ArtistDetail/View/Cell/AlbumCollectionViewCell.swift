//
//  AlbumCollectionViewCell.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateWith(album: Album) {
        
        if album.images.count > 0 {
            imageView.setImageFromUrl(urlString: album.images[0].url, rounded: true)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        nameLabel.text = album.name
    }
    
}
