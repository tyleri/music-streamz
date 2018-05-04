//
//  CartTableViewCell.swift
//  Music Streamz Proj
//
//  Created by Pingdi Huang on 5/1/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    var songLabel: UILabel!
    var artistLabel: UILabel!
    var albumLabel: UILabel!
    //  var albumImage: UIImage!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        songLabel = UILabel()
        songLabel.font = UIFont.systemFont(ofSize: 18)
        songLabel.textColor = .black
        
        artistLabel = UILabel()
        artistLabel.font = UIFont.systemFont(ofSize: 14)
        artistLabel.textColor = .black
        
        albumLabel = UILabel()
        albumLabel.font = UIFont.italicSystemFont(ofSize: 12)
        albumLabel.textColor = .purple
        
        songLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(songLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(albumLabel)
        
        updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            songLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            songLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            songLabel.widthAnchor.constraint(equalToConstant: songLabel.intrinsicContentSize.width)
            ])
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            artistLabel.widthAnchor.constraint(equalToConstant: artistLabel.intrinsicContentSize.width)
            ])
        
        NSLayoutConstraint.activate([
            albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor),
            albumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            albumLabel.widthAnchor.constraint(equalToConstant: albumLabel.intrinsicContentSize.width)
            ])
        
        //NSLayoutConstraint.activate([
        //    imageView?.topAnchor.constraint(equalTo: contentView.topAnchor),
        //    imageView?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        //    imageView?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //    imageView?.widthAnchor.constraint(equalToConstant: imageView?.intrinsicContentSize.width)
        //    ])
        
        super.updateConstraints()
    }
    
}

