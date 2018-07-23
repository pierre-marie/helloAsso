//
//  SearchRepository.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/20/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxSwift

class SearchRepository: NSObject {
    
    let remoteService: SearchRemoteService
    
    init(remoteService: SearchRemoteService) {
        self.remoteService = remoteService
    }
    
    func searchForArtist(artistName: String) -> Observable<[Artist]> {
        return remoteService.searchForArtist(artistName: artistName)
    }
    
}
