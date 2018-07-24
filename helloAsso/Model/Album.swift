//
//  Album.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import Unbox

struct Album {
    
    var id: String = ""
    var name: String = ""
    var images: [SpotifyImage] = []
}

extension Album: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.images = try unboxer.unbox(key: "images")
    }
}
