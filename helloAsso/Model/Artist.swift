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
    var images: [ArtistImage] = []
}

extension Artist: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.genres = try unboxer.unbox(key: "genres")
        self.images = try unboxer.unbox(key: "images")
    }
}

struct ArtistImage {
    let height: Int
    let width: Int
    let url: String
}

extension ArtistImage: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.height = try unboxer.unbox(key: "height")
        self.width = try unboxer.unbox(key: "width")
        self.url = try unboxer.unbox(key: "url")
    }
}
