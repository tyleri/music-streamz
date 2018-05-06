//
//  ResultsViewController.swift
//  Music Streamz Proj
//
//  Created by Tyler Ishikawa on 5/5/18.
//  Copyright © 2018 Pingdi Huang, Alicia Chen, Tyler Ishikawa. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var topLabel: UILabel!
    var middleLabel: UILabel!
    var bottomLabel: UILabel!
    var spotifyImage: UIImageView!
    var appleMusicImage: UIImageView!
    
    var serviceName: String = ""
    
    let spotifyImageUrl = "https://images-na.ssl-images-amazon.com/images/I/51rttY7a%2B9L.png"
    let appleMusicImageUrl = "https://pbs.twimg.com/profile_images/880580416373223424/nKh04sgE.jpg"
    
    var imageConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 35/225, green: 30/225, blue: 30/225, alpha: 1)
        
        
        topLabel = UILabel()
        middleLabel = UILabel()
        bottomLabel = UILabel()
        
        topLabel.text = "The service that's better for you is..."
        middleLabel.text = "\(serviceName)!"
        
        if serviceName != "both" {
            bottomLabel.text = "Based on your selected songs, it looks like \(serviceName) has more of your favorite songs!\n\nCheck out the app by clicking on the image above!"
        } else {
            bottomLabel.text = "Based on your selected songs, it looks like both services have all your favorite songs!\n\nCheck out each service by clicking on their images above!"
        }
        
        topLabel.textColor = UIColor.lightText
        middleLabel.textColor = UIColor.lightText
        bottomLabel.textColor = UIColor.lightText
        
        topLabel.font = .systemFont(ofSize: 24)
        middleLabel.font = .systemFont(ofSize: 24)
        bottomLabel.font = .systemFont(ofSize: 24)
        
        topLabel.numberOfLines = 0
        topLabel.textAlignment = .center
        
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = .center
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        middleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topLabel)
        view.addSubview(middleLabel)
        view.addSubview(bottomLabel)
        
        if serviceName == "Spotify" {
            let imageHeight: CGFloat = 200
            
            spotifyImage = UIImageView()
            spotifyImage.image = urlStringToImage(urlString: spotifyImageUrl, imageHeight: imageHeight)
            
            imageConstraints = [
                spotifyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                spotifyImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 64),
                middleLabel.topAnchor.constraint(equalTo: spotifyImage.bottomAnchor, constant: 16)
            ]
            
            spotifyImage.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(spotifyImage)
        } else if serviceName == "Apple Music" {
            let imageHeight: CGFloat = 200
            
            appleMusicImage = UIImageView()
            appleMusicImage.image = urlStringToImage(urlString: appleMusicImageUrl, imageHeight: imageHeight)
            
            imageConstraints = [
                appleMusicImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                appleMusicImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 64),
                middleLabel.topAnchor.constraint(equalTo: appleMusicImage.bottomAnchor, constant: 16)
            ]
            
            appleMusicImage.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(appleMusicImage)
        } else {
            // serviceName == "both"
            let imageHeight: CGFloat = 150
            
            spotifyImage = UIImageView()
            appleMusicImage = UIImageView()
            
            spotifyImage.image = urlStringToImage(urlString: spotifyImageUrl, imageHeight: imageHeight)
            appleMusicImage.image = urlStringToImage(urlString: appleMusicImageUrl, imageHeight: imageHeight)
            
            imageConstraints = [
                spotifyImage.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
                spotifyImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 64),
                appleMusicImage.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
                appleMusicImage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 64),
                middleLabel.topAnchor.constraint(equalTo: spotifyImage.bottomAnchor, constant: 16)
            ]
            
            spotifyImage.translatesAutoresizingMaskIntoConstraints = false
            appleMusicImage.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(spotifyImage)
            view.addSubview(appleMusicImage)
        }
        
        
        
        
        
        updateConstraints()

    }
    
    func updateConstraints() {
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            middleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            bottomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            bottomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            bottomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate(imageConstraints)
    }
    
    func urlStringToImage(urlString: String, imageHeight: CGFloat) -> UIImage? {
        if let url = NSURL(string: urlString), let data = NSData(contentsOf: url as URL) {
            let urlImage = UIImage(data: data as Data)!
            let ratio = imageHeight / (urlImage.size.height)
            let newSize = CGSize(width: urlImage.size.width * ratio, height: urlImage.size.height * ratio)
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = false
            let renderer = UIGraphicsImageRenderer(size: newSize, format: renderFormat)
            let newImage = renderer.image {
                (context) in urlImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            }
            
            return newImage
        }
        
        return nil
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
