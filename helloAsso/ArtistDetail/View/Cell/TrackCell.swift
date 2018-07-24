//
//  TrackCell.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    func updateWith(track: Track) {
        name.text = track.name
    }
    
}
