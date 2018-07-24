//
//  ArtistViewController.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ArtistViewController: GenericViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var topTracksTable: UITableView!
    @IBOutlet weak var albumsCollection: UICollectionView!
    
    var artist = Artist()
    let viewModel = ArtistViewModel(artistRepository: ArtistRepository(remoteService: ArtistRemoteService()))
    let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: false)
        self.title = NSLocalizedString("ARTIST_DETAIL_TITLE", comment: "")

        topTracksTable.tableFooterView = UIView()
        displayArtistInfo()
        rxBindings()
        
        self.viewModel.fetchArtistTopTracks(artistId: artist.id)
        //self.viewModel.fetchArtistAlbums(artistId: artist.id)
    }
    
    // MARK: Bindings
    
    func rxBindings() {
        
        // top tracks tableView
        viewModel.topTracks
            .bind(to: topTracksTable.rx.items(cellIdentifier: "TrackCell",
                                         cellType: TrackCell.self)) {  row, element, cell in
                                            cell.updateWith(track: element)
            }
            .disposed(by: disposeBag)
        
        // albums collectionView
        viewModel.fetchArtistAlbums(artistId: artist.id)
            .bind(to: albumsCollection.rx.items(cellIdentifier: "AlbumCollectionViewCell",
                                              cellType: AlbumCollectionViewCell.self)) {  row, element, cell in
                                                cell.updateWith(album: element)
            }
            .disposed(by: disposeBag)
        
        // load more albums trigger
        _ = albumsCollection.rx.contentOffset
            .subscribe({ offset in
                let point: CGPoint = self.albumsCollection.contentOffset
                if ((point.y + self.albumsCollection.frame.size.height) >= self.albumsCollection.contentSize.height) {
                    self.viewModel.nextAlbums()
                }
            })
    }
    
    // MARK: Display
    
    func displayArtistInfo() {
        
        name.text = artist.name
        if artist.images.count > 0 {
            artistImageView.setImageFromUrl(urlString: artist.images[0].url, rounded: true)
        }
        if artist.genres.count > 0 {
            genres.text = artist.genres.joined(separator: "-")
        }
    }

}
