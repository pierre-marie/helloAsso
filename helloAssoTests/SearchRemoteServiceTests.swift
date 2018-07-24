//
//  helloAssoTests.swift
//  helloAssoTests
//
//  Created by pierre-marie de jaureguiberry on 7/20/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import XCTest
import RxSwift

@testable import helloAsso

class SearchRemoteServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /*
    curl -X "GET" "https://api.spotify.com/v1/search?q=France%20gall&type=artist&market=FR&limit=1&offset=0" -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer BQA8KmPR_SPsOex8OUGiq9RDB55DC1FU3DKlmRNoJaeYsah9BMvHKeCQXSxmrRaaYBII0m2YNOYjn8m45_pOGimbYhlYihTGFimHf_vj40xuPDhygDZdvVrx8ULpwN1bHR8EPfnCMYE" >> france_gall.json
     */
    func testArtistSearch() {
        
        let expectation = XCTestExpectation(description: "Search for France Gall artist")
        
        let disposeBag = DisposeBag()
        let viewModel = SearchViewModel(searchRepository: SearchRepository(remoteService: SearchRemoteServiceMock()))
        
        viewModel.searchForArtist(artistName: "france_gall")
            .subscribe(onNext: { artists in
                XCTAssert(artists.count == 1)
                let artist = artists[0]
                XCTAssert(artist.name == "France Gall")
                XCTAssert(artist.genres.contains("ye ye"))
                expectation.fulfill()
            }, onError: { error in
                XCTFail()
            }, onCompleted: {
                XCTFail()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
}
