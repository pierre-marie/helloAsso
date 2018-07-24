//
//  ArtistViewModel.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxSwift

class ArtistViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    let lazyLoadingSubject = PublishSubject<Int>()
    private let observableLazyLoading: Observable<Int>
    private var offset: Int = 0
    private let artistRepository: ArtistRepository
    
    init(artistRepository: ArtistRepository) {
        
        self.artistRepository = artistRepository
        self.observableLazyLoading = lazyLoadingSubject
    }
    
    func fetchArtistTopTracks(artistId: String) -> Observable<[Track]> {
        return artistRepository.fetchArtistTopTracks(artistId: artistId)
    }
    
    func fetchArtistAlbums(artistId: String) -> Observable<[Album]> {
        
        return lazyLoadingSubject.distinctUntilChanged()
            .flatMap { index -> Observable<[Album]> in
                self.artistRepository.fetchArtistAlbums(artistId: artistId, offset: index, limit: 12)
            }
            .scan([]) { (lastAlbums, newAlbums) -> [Album] in
                if (newAlbums.count > 0) {
                    self.offset += newAlbums.count
                }
                return lastAlbums + newAlbums
        }
    }
    
    func nextAlbums() {
        lazyLoadingSubject.onNext(offset)
    }
}
