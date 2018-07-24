//
//  GenericViewController.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/24/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: searchBar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
