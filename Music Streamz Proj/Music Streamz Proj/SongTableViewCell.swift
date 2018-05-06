//
//  SongTableViewCell.swift
//  Music Streamz Proj
//
//  Created by Tyler Ishikawa on 5/4/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.

import UIKit

class SongTableViewCell: UITableViewCell {
    
    var albumImageView: UIImageView!
    var songNameLabel: UILabel!
    var artistNameLabel: UILabel!
    var albumNameLabel: UILabel!
    
    var widthConstraints: [NSLayoutConstraint]!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        albumImageView = UIImageView()
        songNameLabel = UILabel()
        artistNameLabel = UILabel()
        albumNameLabel = UILabel()
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        songNameLabel.font = UIFont(name: "BreeSerif-Regular", size: 18)
        artistNameLabel.font = UIFont(name: "Handlee-Regular", size: 18)
        albumNameLabel.font = UIFont(name: "Abel-Regular", size: 18)
        songNameLabel.textColor = UIColor.lightText
        artistNameLabel.textColor = UIColor.lightText
        albumNameLabel.textColor = UIColor.lightText
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(songNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(albumNameLabel)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            albumImageView.widthAnchor.constraint(equalToConstant: (albumImageView.image?.size.width)!)
            ])
        
        NSLayoutConstraint.activate([
            songNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 20),
            songNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            songNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: songNameLabel.leadingAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 4),
            artistNameLabel.trailingAnchor.constraint(equalTo: songNameLabel.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: artistNameLabel.leadingAnchor),
            albumNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 4),
            albumNameLabel.trailingAnchor.constraint(equalTo: artistNameLabel.trailingAnchor)
            ])
        
        super.updateConstraints()
    }
    
    override func prepareForReuse() {
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

