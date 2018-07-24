//
//  Artist.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/20/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import Unbox

struct Artist {
    
    var id: String = ""
    var name: String = ""
    var genres: [String] = []
    var images: [SpotifyImage] = []
}

extension Artist: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.genres = try unboxer.unbox(key: "genres")
        self.images = try unboxer.unbox(key: "images")
    }
}

