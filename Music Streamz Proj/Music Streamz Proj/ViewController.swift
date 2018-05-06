//
//  ViewController.swift
//  Music Streamz Proj
//
//  Created by Pingdi Huang on 5/1/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SearchViewControllerDelegate
{
    
    var homeTitle: UILabel!
    var collectionView: UICollectionView!
    var searchButton: UIButton!
    var cartButton: UIButton!
    let reuseCell = "reuseCollectionViewCell"
    var searchImage: UIImage!
    
    var recommendedSongs: [Song] = []
    var pickedSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        homeTitle = UILabel()
        homeTitle.text = "Song Suggestions"
        homeTitle.font = UIFont(name: "Luna", size: 25)
        homeTitle.textColor = UIColor(red: 29/225, green: 185/225, blue: 84/225, alpha: 1)
        homeTitle.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton = UIButton()
        resize(ratio: 30, image: #imageLiteral(resourceName: "search button.png"), resizeButton: searchButton)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        cartButton = UIButton()
        resize(ratio: 30, image: #imageLiteral(resourceName: "cart icon.png"), resizeButton: cartButton)
        cartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
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
            homeTitle.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 16),
            homeTitle.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -30)
            ])
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: homeTitle.topAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            cartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cartButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartButton.bottomAnchor.constraint(equalTo: homeTitle.topAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            collectionView.topAnchor.constraint(equalTo: homeTitle.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    func resize(ratio: CGFloat, image: UIImage, resizeButton: UIButton)
    {
        let size = ratio/(image.size.height)
        let adjustedSize = CGSize(width: image.size.width * size, height: image.size.height * size)
        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.opaque = false
        let renderer = UIGraphicsImageRenderer(size: adjustedSize, format: renderFormat)
        let newImage = renderer.image {
            (context) in image.draw(in: CGRect(x: 0, y: 0, width: adjustedSize.width, height: adjustedSize.height))
        }
        resizeButton.setBackgroundImage(newImage, for: .normal)
    }
    
    func createSongs() {
        Network.getRecommendations(pickedSongs: pickedSongs, limit: 4) { (recommendations) in
            self.recommendedSongs = recommendations
            self.collectionView.reloadData()
        }
    }
    
    func truncateInfo(text: String, number: Int) -> String {
        //truncate accordingly to font size. Title = 16 characters, Artist = 17, Album = 19
        if (text.count > number ) {
            return String(text.prefix(number) + "...")
        } else {
            return text
        }
    }
    
    @objc func searchButtonPressed(_ target: UIButton)
    {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        let navController = UINavigationController(rootViewController: searchVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc func cartButtonPressed(_ target: UIButton)
    {
        let cartViewController = CartViewController()
        cartViewController.pickedSongs = pickedSongs
        
        navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedSongs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width - 10)/2), height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as! PlaylistCollectionViewCell
        let song = recommendedSongs[indexPath.row]
        cell.songLabel.text = truncateInfo(text: song.name, number: 16)
        cell.artistLabel.text = truncateInfo(text: song.artist, number: 17)
        cell.albumLabel.text = truncateInfo(text: song.album, number: 19)
        cell.backgroundColor = UIColor(red: 221/225, green: 220/225, blue: 220/225, alpha: 0.8)
        
        let currSong = recommendedSongs[indexPath.row]
        
        if let url = NSURL(string: currSong.imageUrl), let data = NSData(contentsOf: url as URL) {
            let urlImage = UIImage(data: data as Data)!
            let ratio = 250 / (urlImage.size.height)
            let newSize = CGSize(width: urlImage.size.width * ratio, height: urlImage.size.height * ratio)
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = false
            let renderer = UIGraphicsImageRenderer(size: newSize, format: renderFormat)
            let newImage = renderer.image {
                (context) in urlImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            }
            
            cell.albumImage.image = newImage
        }
        
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func addSongsToCart(songs: [Song]) {
        for song in songs {
            if !pickedSongs.contains(song) {
                pickedSongs.append(song)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



