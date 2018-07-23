//
//  ArtistCellTableViewCell.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit

class ArtistCellTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    func updateWith(artist: Artist) {
        
        name.text = artist.name
        if artist.images.count > 0 {
            artistImageView.setImageFromUrl(urlString: artist.images[0].url, rounded: true)
        }
        if artist.genres.count > 0 {
            genres.text = artist.genres.joined(separator: "-")
        }
    }

}
