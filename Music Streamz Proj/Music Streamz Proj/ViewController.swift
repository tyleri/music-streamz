//
//  ViewController.swift
//  Music Streamz Proj
//
//  Created by Pingdi Huang on 5/1/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AVAudioPlayerDelegate
{
    
    var homeTitle: UILabel!
    var collectionView: UICollectionView!
    var searchButton: UIButton!
    var cartButton: UIButton!
    var songs: [Song] = [Song]()
    let reuseCell = "reuseCollectionViewCell"
    var searchImage: UIImage!
    var player = AVAudioPlayer()
    
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
        
        //player.delegate = self
        
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
        let song1 = Song(name: "Likey", artist: "Twice", album: "Twicetagram", imageUrl: "https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/e8/83/01/e8830188-ff85-a4b6-6939-d450cbf1b56a/10-1_20171030_0AM_LIKEY-COVER-PHOTO_3000.jpg/268x0w.jpg", audioUrl: "https://p.scdn.co/mp3-preview/9604306c63f1c6dbe9a2d55ec49b96c9b746d13f?cid=121f626841d94410ae59706d9f7644c9")
        let song2 = Song(name: "TT", artist: "Twice", album: "TWICEcoaster: Lane 1", imageUrl: "https://pre00.deviantart.net/2405/th/pre/f/2017/051/6/e/twice___twicecoaster___lane_1_by_tsukinofleur-damgdub.png", audioUrl: "https://p.scdn.co/mp3-preview/9604306c63f1c6dbe9a2d55ec49b96c9b746d13f?cid=121f626841d94410ae59706d9f7644c9")
        let song3 = Song(name: "Scentist", artist: "VIXX", album: "Eau de Vixx", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM9w9GXTM4mgpPuUOYLhw7_eS3nbD-MJM-XAbAJD9AG3uyWTSs", audioUrl: "https://p.scdn.co/mp3-preview/29c02e7d34a5e1cb0ea01c975c2d421401cc7101?cid=121f626841d94410ae59706d9f7644c9")
        let song4 = Song(name: "Done for Me", artist: "Charlie Puth ft. Kehlani", album: "Voicenotes", imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music128/v4/4b/ea/5e/4bea5eb1-9cd2-e0c7-c0da-9ec0f230a44b/075679892041.jpg/600x600bf.jpg", audioUrl: "https://p.scdn.co/mp3-preview/29c02e7d34a5e1cb0ea01c975c2d421401cc7101?cid=121f626841d94410ae59706d9f7644c9")
        songs = [song1, song2, song3, song4]
    }
    
    @objc func searchButtonPressed(_ target: UIButton)
    {
        let searchVC = SearchViewController()
        let navController = UINavigationController(rootViewController: searchVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc func cartButtonPressed(_ target: UIButton)
    {
        let cartViewController = CartViewController()
        
        navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 //front page suggestion songs
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width - 10)/2), height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as! PlaylistCollectionViewCell
        let song = songs[indexPath.row]
        cell.songLabel.text = song.name
        cell.artistLabel.text = song.artist
        cell.albumLabel.text = song.album
        cell.backgroundColor = UIColor(red: 221/225, green: 220/225, blue: 220/225, alpha: 0.8)
        
        let currSong = songs[indexPath.row]
        
        if let url = NSURL(string: currSong.imageUrl), let data = NSData(contentsOf: url as URL) {
            let urlImage = UIImage(data: data as Data)!
            let ratio = 200 / (urlImage.size.height)
            let newSize = CGSize(width: urlImage.size.width * ratio, height: urlImage.size.height * ratio)
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = false
            let renderer = UIGraphicsImageRenderer(size: newSize, format: renderFormat)
            let newImage = renderer.image {
                (context) in urlImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            }
            
            cell.albumImage.image = newImage
        }
        
//        func downloadFileFromURL(url: NSURL){
//            var task: URLSessionDownloadTask
//            task = URLSession(configuration: .default).downloadTask(with: url, completionHandler: { [weak self] (URL, response, error) -> Void in
//
//                if True {
//                    player.prepareToPlay()
//                    player.volume = 1.0
//                    player.play()
//                } else {
//                    print("File failed")
//                }
//            })
//            task.resume()
//        }
//
//        if let url = NSURL(string: currSong.audioUrl), let clip = NSData(contentsOf: url as URL){
//            downloadFileFromURL(url: url)
//        }
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



