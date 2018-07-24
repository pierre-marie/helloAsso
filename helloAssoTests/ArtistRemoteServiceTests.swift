//
//  ArtistRemoteServiceTests.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/24/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import XCTest
import RxSwift

@testable import helloAsso

class ArtistRemoteServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /*
     curl -X "GET" "https://api.spotify.com/v1/artists/22HVxZPA6UhBp8wahxDA6I/top-tracks?country=FR" -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer BQA8KmPR_SPsOex8OUGiq9RDB55DC1FU3DKlmRNoJaeYsah9BMvHKeCQXSxmrRaaYBII0m2YNOYjn8m45_pOGimbYhlYihTGFimHf_vj40xuPDhygDZdvVrx8ULpwN1bHR8EPfnCMYE" >> 22HVxZPA6UhBp8wahxDA6I.json
     */
    
    func testArtistTopTracks() {
        
        let expectation = XCTestExpectation(description: "Search for France Gall top tracks")
        
        let disposeBag = DisposeBag()
        let viewModel = ArtistViewModel(artistRepository: ArtistRepository(remoteService: ArtistRemoteServiceMock()))
        
        viewModel.fetchArtistTopTracks(artistId: "22HVxZPA6UhBp8wahxDA6I")
            .subscribe(onNext: { tracks in
                XCTAssert(tracks.count == 10)
                expectation.fulfill()
            }, onError: { error in
                XCTFail()
            }, onCompleted: {
                XCTFail()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    /*
     curl -X "GET" "https://api.spotify.com/v1/artists/7mAqCk75DUBWgcC0sqhzwX/albums?include_groups=single%2Cappears_on&market=FR&limit=10&offset=0" -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer BQA8KmPR_SPsOex8OUGiq9RDB55DC1FU3DKlmRNoJaeYsah9BMvHKeCQXSxmrRaaYBII0m2YNOYjn8m45_pOGimbYhlYihTGFimHf_vj40xuPDhygDZdvVrx8ULpwN1bHR8EPfnCMYE" >> 7mAqCk75DUBWgcC0sqhzwX.json
     */
    
    func testArtistAlbums() {
        
        let expectation = XCTestExpectation(description: "Search for John 5 albums")
        
        let disposeBag = DisposeBag()
        let viewModel = ArtistViewModel(artistRepository: ArtistRepository(remoteService: ArtistRemoteServiceMock()))
        
        viewModel.fetchArtistAlbums(artistId: "7mAqCk75DUBWgcC0sqhzwX")
            .subscribe(onNext: { albums in
                XCTAssert(albums.count == 10)
                expectation.fulfill()
            }, onError: { error in
                XCTFail()
            }, onCompleted: {
                XCTFail()
            })
            .disposed(by: disposeBag)
        viewModel.nextAlbums()
        
        wait(for: [expectation], timeout: 2.0)
    }
}

