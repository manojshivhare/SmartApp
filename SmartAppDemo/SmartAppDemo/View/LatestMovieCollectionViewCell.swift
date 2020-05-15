//
//  LatestMovieCollectionViewCell.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 15/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import UIKit

class LatestMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    //Set up value into outlet
       var dataModelDic: Results! {
           didSet {
            let imageURLStr = String(format: "https://image.tmdb.org/t/p/w342/%@",self.dataModelDic.poster_path!)
               
               //download image from url
               self.getDataFromImageURL(from: URL(string:imageURLStr)!) { (image) in
                   self.movieImageView.image = image
               }
               
               //set contact name
               self.movieTitleLabel.text = self.dataModelDic.title
               self.movieDescriptionLabel.text = self.dataModelDic.overview
           }
       }
    
    //MARK: Download image from URL
    func getDataFromImageURL(from url: URL, completionBlock: @escaping (UIImage) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else    {
                    return
            }
            DispatchQueue.main.async() { () -> Void in
                completionBlock(image)
            }
        }.resume()
    }
}
