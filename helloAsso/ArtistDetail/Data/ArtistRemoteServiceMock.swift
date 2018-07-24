//
//  ArtistRemoteServiceMock.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/24/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import Unbox

class ArtistRemoteServiceMock: ArtistRemoteService {
    
    override func fetchArtistTopTracks(artistId: String) -> Observable<[Track]> {
        
        return Observable<[Track]>.create { (observer) -> Disposable in
            
            var trackObjects: [Track] = []
            if let path = Bundle.main.path(forResource: artistId, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResultDic = jsonResult as? [String : Any] {
                        if let tracks = jsonResultDic["tracks"] as? [Any] {
                            for track in tracks {
                                if let trackDic = track as? [String : Any] {
                                    do {
                                        let t: Track = try unbox(dictionary: trackDic)
                                        trackObjects.append(t)
                                    } catch {
                                        print("Something went wrong: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("Error opening file")
                }
            }
            observer.onNext(trackObjects)
            return Disposables.create()
        }
    }
    
    override func fetchArtistAlbums(artistId: String, offset: Int, limit: Int) -> Observable<[Album]> {
        
        return Observable<[Album]>.create { (observer) -> Disposable in
            
            var albumObjects: [Album] = []
            if let path = Bundle.main.path(forResource: artistId, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResultDic = jsonResult as? [String : Any] {
                        if let items = jsonResultDic["items"] as? [Any] {
                            for item in items {
                                if let albumDic = item as? [String : Any] {
                                    do {
                                        let a: Album = try unbox(dictionary: albumDic)
                                        albumObjects.append(a)
                                    } catch {
                                        print("Something went wrong: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("Error opening file")
                }
            }
            observer.onNext(albumObjects)
            return Disposables.create()
        }
    }
}
