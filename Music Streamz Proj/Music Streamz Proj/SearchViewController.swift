//
//  SearchViewController.swift
//  Music Streamz Proj
//
//  Created by Alicia Chen on 5/3/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit
import AVFoundation

protocol SearchViewControllerDelegate {
    func addSongsToCart(songs: [Song])
    func createSongs()
}

class SearchViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate
{
    var delegate: SearchViewControllerDelegate?
    
    var searchController: UISearchController!
    var timer: Timer?
    var songsList: [Song] = []
    var selectedSongsSet: Set<Song>!
    
    let songCellIndentifier = "SongCell"
    let cellHeight: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedSongsSet = Set<Song>()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissButtonPressed(sender:)))
        self.title = "Search"
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.backgroundColor = .green
        searchController.searchBar.placeholder = "Search for artists, albums, songs"
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: songCellIndentifier)
        
        definesPresentationContext = true
        
    }
    
    @objc func dismissButtonPressed(sender: UIButton)
    {
        for song in selectedSongsSet {
            print(song)
        }
        delegate?.addSongsToCart(songs: Array(selectedSongsSet))
        delegate?.createSongs()
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: songCellIndentifier) as! SongTableViewCell
        let currSong = songsList[indexPath.row]
        cell.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        cell.songNameLabel.text = currSong.name
        cell.artistNameLabel.text = currSong.artist
        cell.albumNameLabel.text = currSong.album
        
        if let url = NSURL(string: currSong.imageUrl), let data = NSData(contentsOf: url as URL) {
            let urlImage = UIImage(data: data as Data)!
            let ratio = cellHeight / (urlImage.size.height)
            let newSize = CGSize(width: urlImage.size.width * ratio, height: urlImage.size.height * ratio)
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = false
            let renderer = UIGraphicsImageRenderer(size: newSize, format: renderFormat)
            let newImage = renderer.image {
                (context) in urlImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            }
            
            cell.albumImageView.image = newImage
        }
        
        cell.accessoryType = selectedSongsSet.contains(currSong) ? .checkmark : .none
        
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .none {
                print(songsList[indexPath.row])
                selectedSongsSet.insert(songsList[indexPath.row])
                cell.accessoryType = .checkmark
            } else {
                selectedSongsSet.remove(songsList[indexPath.row])
                cell.accessoryType = .none
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(searchTracks(_:)), userInfo: ["searchText": searchController.searchBar.text], repeats: false)
    }
    
    @objc func searchTracks(_ timer: Timer)
    {
        guard
            let userInfo = timer.userInfo as? [String: String],
            let searchText = userInfo["searchText"]
            else {
                return
        }
        
        if searchText == "" {
            self.songsList = []
            self.tableView.reloadData()
        } else {
            Network.searchSongs(query: searchText, { (songsList) in
                self.songsList = songsList
                self.tableView.reloadData()
            })
        }
    }
    
}

