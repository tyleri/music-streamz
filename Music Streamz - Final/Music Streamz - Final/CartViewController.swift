//  
//  CartViewController.swift
//  Music Streamz - Final
//
//  Created by Tyler Ishikawa on 4/28/18.
//  Copyright © 2018 Tyler Ishikawa, Alicia Chen, Pingdi Huang, Jingqi Zhou. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var playlistTableView: UITableView!
    var saveButton: UIButton!
    var dismissButton: UIButton!
    //var delegate: SaveButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Playlist"
        view.backgroundColor = .white
        
        playlistTableView = UITableView()
        playlistTableView.dataSource = self
        playlistTableView.delegate = self
        playlistTableView.bounces = true
        playlistTableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartCell")
        playlistTableView.translatesAutoresizingMaskIntoConstraints = false
        
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
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Songs"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        
        cell.setNeedsUpdateConstraints()
        
        return cell
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
