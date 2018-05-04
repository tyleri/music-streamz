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
    //var delegate: SaveButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Playlist"
        view.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        
        playlistTableView = UITableView()
        playlistTableView.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        playlistTableView.dataSource = self
        playlistTableView.delegate = self
        playlistTableView.bounces = true
        playlistTableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartCell")
        playlistTableView.translatesAutoresizingMaskIntoConstraints = false
        headerView = UIView()
        headerView.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        headerTitle = UILabel()
        headerTitle.text = "Songs"
        headerTitle.textColor = UIColor(red: 29/225, green: 185/225, blue: 84/225, alpha: 1)
        headerTitle.font = UIFont(name: "Luna", size: 16)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerTitle)
        view.addSubview(playlistTableView)
        
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
        
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
//    {
//        return "Songs"
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        cell.backgroundColor = UIColor(red: 221/225, green: 220/225, blue: 220/225, alpha: 0.8)
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
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

