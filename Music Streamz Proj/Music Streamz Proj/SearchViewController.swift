//
//  SearchViewController.swift
//  Music Streamz Proj
//
//  Created by Pingdi Huang on 5/3/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit
import AVFoundation

class SearchViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate
{
    
    var searchController: UISearchController!
    var timer: Timer?
    let songCellIndentifier = "SongCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissButtonPressed(sender:)))
        self.title = "Search"

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for artists, albums, songs"
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        
    }
    
    @objc func dismissButtonPressed(sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // not sure if I need to include the songs (haven't implemented the API yet)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: songCellIndentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: songCellIndentifier)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(searchTracks(_:)), userInfo: ["searchText": searchText], repeats: false)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text
        {
            if !searchText.isEmpty
            {
                
            }
        }
    }
    
    @objc func searchTracks(_ timer: Timer)
    {
        guard
            let userInfo = timer.userInfo as? [String: String],
            let searchText = userInfo["searchText"]
            else {
                return
        }
        
        //        Network.searchTracks(withQuery: searchText)
        //        {
        //
        //        }
    }
    
}

