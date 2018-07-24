//
//  SearchRemoteServiceMock.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/24/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import Unbox

class SearchRemoteServiceMock: SearchRemoteService {
    
    override func searchForArtist(artistName: String) -> Observable<[Artist]> {
        
        return Observable<[Artist]>.create { (observer) -> Disposable in
            
            var artistObjects: [Artist] = []
            if let path = Bundle.main.path(forResource: artistName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResultDic = jsonResult as? [String : Any] {
                        if let artists = jsonResultDic["artists"] as? [String : Any] {
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
                } catch {
                    print("Error opening file")
                }
            }
            observer.onNext(artistObjects)
            return Disposables.create()
        }
    }
}
