//
//  PlaylistCollectionViewCell.swift
//  Music Streamz Proj
//
//  Created by Pingdi Huang on 5/1/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    var songLabel: UILabel!
    var artistLabel: UILabel!
    var albumLabel: UILabel!
    var albumImage: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        songLabel = UILabel()
        songLabel.font = UIFont(name: "BreeSerif-Regular", size: 18)
        songLabel.textColor = .black
        
        artistLabel = UILabel()
        artistLabel.font = UIFont(name: "Handlee-Regular", size: 14)
        artistLabel.textColor = .black
        
        albumLabel = UILabel()
        albumLabel.font = UIFont(name: "Abel-Regular", size: 14)
        albumLabel.textColor = .purple
        
        albumImage = UIImageView()
        albumImage.contentMode = .scaleToFill
        albumImage.layer.cornerRadius = 6
        
        songLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(albumImage)
        contentView.addSubview(songLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(albumLabel)
    }
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            songLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -64),
            songLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            songLabel.widthAnchor.constraint(equalToConstant: songLabel.intrinsicContentSize.width)
            ])
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            artistLabel.widthAnchor.constraint(equalToConstant: artistLabel.intrinsicContentSize.width)
            ])
        
        NSLayoutConstraint.activate([
            albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor),
            albumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            albumLabel.widthAnchor.constraint(equalToConstant: albumLabel.intrinsicContentSize.width)
            ])
        
        NSLayoutConstraint.activate([
            albumImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            albumImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumImage.bottomAnchor.constraint(equalTo: songLabel.topAnchor, constant: -4)
            ])
        
        super.updateConstraints()
    }
}




