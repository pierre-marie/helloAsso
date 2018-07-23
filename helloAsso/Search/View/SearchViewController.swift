//
//  ViewController.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/20/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var artists: [Artist] = []
    let viewModel = SearchViewModel(searchRepository: SearchRepository(remoteService: SearchRemoteService()))
    let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = NSLocalizedString("ARTIST_SEARCH_TITLE", comment: "")

        searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in
                self.viewModel.searchForArtist(artistName: query)
                    .subscribe(onNext: { a in
                        self.artists = a
                        self.resultsTable.reloadData()
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: TableView delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ArtistCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! ArtistCellTableViewCell
        let artist = artists[indexPath.row]
        cell.updateWith(artist: artist)
        return cell
    }

}

