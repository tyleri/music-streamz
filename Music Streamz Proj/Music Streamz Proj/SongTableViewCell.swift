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
        
        widthConstraints = []
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(songNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(albumNameLabel)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.deactivate(widthConstraints)
        
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            songNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 16),
            songNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
            ])
        
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: songNameLabel.leadingAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 8)
            ])
        
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: artistNameLabel.leadingAnchor),
            albumNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8)
            ])
        
        // width constraints
        widthConstraints = [
            songNameLabel.widthAnchor.constraint(equalToConstant: songNameLabel.intrinsicContentSize.width),
            artistNameLabel.widthAnchor.constraint(equalToConstant: artistNameLabel.intrinsicContentSize.width),
            albumNameLabel.widthAnchor.constraint(equalToConstant: albumNameLabel.intrinsicContentSize.width)
        ]
        
        NSLayoutConstraint.activate(widthConstraints)
        
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
