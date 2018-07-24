//
//  ArtistRepository.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxSwift

class ArtistRepository: NSObject {
    
    let remoteService: ArtistRemoteService
    
    init(remoteService: ArtistRemoteService) {
        self.remoteService = remoteService
    }
    
    func fetchArtistTopTracks(artistId: String) -> Observable<[Track]> {
        return remoteService.fetchArtistTopTracks(artistId: artistId)
    }
    
    func fetchArtistAlbums(artistId: String, offset: Int, limit: Int) -> Observable<[Album]> {
        return remoteService.fetchArtistAlbums(artistId: artistId, offset: offset, limit: limit)
    }
    
}
