//
//  Song.swift
//
//
//  Created by Tyler Ishikawa, Alicia Chen, Pingdi Huang, Jingqi Zhou on 4/27/18.
//  Copyright © 2018 Tyler. All rights reserved.
//
import UIKit
import Foundation

class Song {
    
    var name: String
    var artist: String
    var album: String
    //var image: UIImage
    
    init(name: String, artist: String, album: String) {
        self.name = name
        self.artist = artist
        self.album = album
        //self.image = UIImage()
    }
}

