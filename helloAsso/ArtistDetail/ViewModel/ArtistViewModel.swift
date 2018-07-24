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
    
    private var topTracksVariable = Variable<[Track]>([])
    var topTracks: Observable<[Track]> {
        return topTracksVariable.asObservable()
    }
    
    private var albumsVariable = Variable<[Album]>([])
    var albums: Observable<[Album]> {
        return albumsVariable.asObservable()
    }
    
    init(artistRepository: ArtistRepository) {
        
        self.artistRepository = artistRepository
        self.observableLazyLoading = lazyLoadingSubject
    }
    
    func fetchArtistTopTracks(artistId: String) {
        
        artistRepository.fetchArtistTopTracks(artistId: artistId)
            .subscribe(onNext: { tracks in
                print("fetchArtistTopTracks tracks.count = \(tracks.count)")
                self.topTracksVariable.value = tracks
            }, onError: { error in
                print("fetchArtistTopTracks onError")
            })
            .disposed(by: disposeBag)
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
