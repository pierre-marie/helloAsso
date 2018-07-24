//
//  SearchRemoteService.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/20/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import Unbox

class SearchRemoteService: NSObject {
    
    // MARK: GET public playlists of a user
    
    func searchForArtist(artistName: String) -> Observable<[Artist]> {
        
        return Observable<[Artist]>.create { (observer) -> Disposable in
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(UserToken.sharedInstance.getToken())",
                "Accept": "application/json"
            ]
            
            let url = "https://api.spotify.com/v1/search?q=\(artistName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")&type=artist"
            let requestReference = Alamofire.request(url,
                                                     method: .get,
                                                     encoding: JSONEncoding.default,
                                                     headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        var artistObjects: [Artist] = []
                        if let result = response.result.value as? [String : Any] {
                            if let artists = result["artists"] as? [String : Any] {
                                if let items = artists["items"] as? [Any] {
                                    for artist in items {
                                        if let artistDic = artist as? [String : Any] {
                                            do {
                                                let a: Artist = try unbox(dictionary: artistDic)
                                                artistObjects.append(a)
                                            } catch {
                                                print("Something went wrong: \(error.localizedDescription)")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        observer.onNext(artistObjects)
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
