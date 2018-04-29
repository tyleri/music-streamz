//  Main View Controller
//  ViewController.swift
//  Music Streamz - Final
//
//  Created by Tyler Ishikawa on 4/28/18.
//  Copyright © 2018 Tyler Ishikawa, Alicia Chen, Pingdi Huang, Jingqi Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    var homeTitle: UILabel!
    var collectionView: UICollectionView!
    var searchButton: UIButton!
    var cartButton: UIButton!
    var songs: [Song] = [Song]()
    let reuseCell = "reuseCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Music Streamz"
        
        homeTitle = UILabel()
        homeTitle.text = "Suggestions by Yours Truly"
        homeTitle.font = UIFont.boldSystemFont(ofSize: 16)
        homeTitle.textColor = .black
        homeTitle.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton = UIButton()
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        //searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        cartButton = UIButton()
        cartButton.setTitle("Cart", for: .normal)
        cartButton.setTitleColor(.black, for: .normal)
        cartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: reuseCell)
        layout.itemSize = CGSize(width: 180, height: 180)
        
        createSongs()
        
        view.addSubview(homeTitle)
        view.addSubview(searchButton)
        view.addSubview(cartButton)
        view.addSubview(collectionView)
        setUpConstraints()
    }
    
    func setUpConstraints()
    {
        NSLayoutConstraint.activate([
            homeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeTitle.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 8),
            homeTitle.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: homeTitle.topAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            cartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cartButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartButton.bottomAnchor.constraint(equalTo: homeTitle.topAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: homeTitle.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    func createSongs() {
        let song1 = Song(name: "Likey", artist: "Twice", album: "Twicetagram")
        let song2 = Song(name: "TT", artist: "Twice", album: "TWICEcoaster: Lane 1")
        let song3 = Song(name: "Scentist", artist: "VIXX", album: "Eau de Vixx")
        let song4 = Song(name: "Done for Me", artist: "Charlie Puth ft. Kehlani", album: "Voicenotes")
        songs = [song1, song2, song3, song4]
    }

//    @objc func searchButtonPressed(_ target: UIButton)
//    {
//        let searchVC = SearchViewController()
//        navigationController?.pushViewController(searchVC, animated: true)
//
//        let modalSearchController = UINavigationController(rootViewController: searchVC)
//        let dismissButton = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissViewController))
//        searchVC.navigationItem.leftBarButtonItem = dismissButton
//        navigationController?.present(modalSearchController, animated: true)
//    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc func cartButtonPressed(_ target: UIButton)
    {
        let cartViewController = CartViewController()

        navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 //front page suggestion playlists
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as! PlaylistCollectionViewCell
        let song = songs[indexPath.row]
        cell.songLabel.text = song.name
        cell.artistLabel.text = song.artist
        cell.albumLabel.text = song.album
        cell.backgroundColor = .gray
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

