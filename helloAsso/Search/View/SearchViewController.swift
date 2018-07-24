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

class SearchViewController: GenericViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var artists: [Artist] = []
    var selectedArtistIndex: Int = 0
    let viewModel = SearchViewModel(searchRepository: SearchRepository(remoteService: SearchRemoteService()))
    let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = NSLocalizedString("ARTIST_SEARCH_TITLE", comment: "")
        
        resultsTable.tableFooterView = UIView()
        searchBar.placeholder = NSLocalizedString("ARTIST_SEARCH_FIELD_PLACEHOLDER", comment: "")
        
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

    // MARK: TableView delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ArtistCell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! ArtistCell
        let artist = artists[indexPath.row]
        cell.updateWith(artist: artist)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedArtistIndex = indexPath.row
        performSegue(withIdentifier: "goArtistDetail", sender: self)
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "goArtistDetail") {
            let destinationViewController: ArtistViewController = segue.destination as! ArtistViewController
            destinationViewController.artist = artists[selectedArtistIndex]
            print(destinationViewController.artist)
        }
    }
    
}

