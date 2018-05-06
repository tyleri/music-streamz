//
//  CartViewController.swift
//  Music Streamz Proj
//
//  Created by Pingdi Huang on 5/1/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var playlistTableView: UITableView!
    var headerView: UIView!
    var saveButton: UIButton!
    var dismissButton: UIButton!
    var headerTitle: UILabel!
    var resultsButton: UIButton!
    //var delegate: SaveButtonDelegate?
    
    var pickedSongs: [Song] = []
    
    let songCellIdentifier: String = "SongCell"
    let cellHeight: CGFloat = 100
    let resultsButtonRadius: CGFloat = 30

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Playlist"
        view.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        
        playlistTableView = UITableView()
        playlistTableView.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        playlistTableView.dataSource = self
        playlistTableView.delegate = self
        playlistTableView.bounces = true
        playlistTableView.register(SongTableViewCell.self, forCellReuseIdentifier: songCellIdentifier)
        playlistTableView.translatesAutoresizingMaskIntoConstraints = false
        headerView = UIView()
        headerView.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        headerTitle = UILabel()
        headerTitle.text = "Songs"
        headerTitle.textColor = UIColor(red: 29/225, green: 185/225, blue: 84/225, alpha: 1)
        headerTitle.font = UIFont(name: "Luna", size: 16)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        resultsButton = UIButton()
        resultsButton.setTitle("→", for: .normal)
        resultsButton.titleLabel?.font = .systemFont(ofSize: 30)
        resultsButton.setTitleColor(UIColor.white, for: .normal)
        resultsButton.backgroundColor = UIColor(red: 29/225, green: 185/225, blue: 84/225, alpha: 1)
        resultsButton.layer.cornerRadius = resultsButtonRadius
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerTitle)
        view.addSubview(playlistTableView)
        view.addSubview(resultsButton)
        
        setUpConstraints()
    }
    
    func setUpConstraints()
    {
        NSLayoutConstraint.activate([
            playlistTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playlistTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playlistTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playlistTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
            headerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            resultsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resultsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            resultsButton.widthAnchor.constraint(equalToConstant: resultsButtonRadius * 2),
            resultsButton.heightAnchor.constraint(equalToConstant: resultsButtonRadius * 2)
            ])
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
//    {
//        return "Songs"
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickedSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: songCellIdentifier) as! SongTableViewCell
//        cell.backgroundColor = UIColor(red: 221/225, green: 220/225, blue: 220/225, alpha: 0.8)
        cell.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        
        let currSong = pickedSongs[indexPath.row]
        
        cell.songNameLabel.text = currSong.name
        cell.artistNameLabel.text = currSong.artist
        cell.albumNameLabel.text = currSong.album
        
        cell.songNameLabel.textColor = UIColor.lightText
        cell.artistNameLabel.textColor = UIColor.lightText
        cell.albumNameLabel.textColor = UIColor.lightText
        
        cell.songNameLabel.font = UIFont(name: "BreeSerif-Regular", size: 18)
        cell.artistNameLabel.font = UIFont(name: "Handlee-Regular", size: 18)
        cell.albumNameLabel.font = UIFont(name: "Abel-Regular", size: 18)
        
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
        
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

