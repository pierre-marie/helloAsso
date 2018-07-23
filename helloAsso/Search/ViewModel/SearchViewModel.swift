//
//  SearchViewModel.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/20/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    private let searchRepository: SearchRepository
    
    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func searchForArtist(artistName: String) -> Observable<[Artist]> {
        return searchRepository.searchForArtist(artistName: artistName)
    }
}
