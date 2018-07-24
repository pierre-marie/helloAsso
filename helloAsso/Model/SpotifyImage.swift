//
//  SpotifyImage.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import Unbox

struct SpotifyImage {
    let height: Int
    let width: Int
    let url: String
}

extension SpotifyImage: Unboxable {
    
    init(unboxer: Unboxer) throws {
        self.height = try unboxer.unbox(key: "height")
        self.width = try unboxer.unbox(key: "width")
        self.url = try unboxer.unbox(key: "url")
    }
}
