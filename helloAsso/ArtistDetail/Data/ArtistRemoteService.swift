//
//  ArtistRemoteService.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import Unbox

class ArtistRemoteService: NSObject {
    
    // MARK: GET artist top tracks
    
    func fetchArtistTopTracks(artistId: String) -> Observable<[Track]> {
        
        return Observable<[Track]>.create { (observer) -> Disposable in
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(UserToken.sharedInstance.getToken())",
                "Accept": "application/json"
            ]
            
            let langStr = Locale.current.languageCode?.uppercased()
            let url = "https://api.spotify.com/v1/artists/\(artistId)/top-tracks?country=\(langStr ?? "FR")"
            let requestReference = Alamofire.request(url,
                                                     method: .get,
                                                     encoding: JSONEncoding.default,
                                                     headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        var trackObjects: [Track] = []
                        if let result = response.result.value as? [String : Any] {
                            if let tracks = result["tracks"] as? [Any] {
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
                        observer.onNext(trackObjects)
                    case .failure:
                        observer.onError(response.error!)
                    }
            }
            return Disposables.create(with: {
                requestReference.cancel()
            })
        }
    }
    
    // MARK: GET artist albums with lazzy loadings
    
    func fetchArtistAlbums(artistId: String, offset: Int, limit: Int) -> Observable<[Album]> {
        
        return Observable<[Album]>.create { (observer) -> Disposable in
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(UserToken.sharedInstance.getToken())",
                "Accept": "application/json"
            ]
            
            let langStr = Locale.current.languageCode?.uppercased()
            let url = "https://api.spotify.com/v1/artists/\(artistId)/albums?market=\(langStr ?? "FR")&limit=\(limit)&offset=\(offset)"
            let requestReference = Alamofire.request(url,
                                                     method: .get,
                                                     encoding: JSONEncoding.default,
                                                     headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        var albumObjects: [Album] = []
                        if let result = response.result.value as? [String : Any] {
                            if let items = result["items"] as? [Any] {
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
                        observer.onNext(albumObjects)
                    case .failure:
                        observer.onError(response.error!)
                    }
            }
            return Disposables.create(with: {
                requestReference.cancel()
            })
        }
    }
}

