//
//  LatestMovieCollectionViewCell.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 15/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import UIKit

class LatestMovieCollectionViewCell: UICollectionViewCell,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var movieDeleteBtn: UIButton!
    
    
    var dataModelArr: [Results]?
    
  //Set up value into outlet
    var dataModelDic: Results! {
        didSet {
            let imageURLStr = String(format: "https://image.tmdb.org/t/p/w342%@",self.dataModelDic.poster_path!)
            
            //download image from url
            ApiManager.shared.downloadImageFile(urlString: imageURLStr, success: { (image) in
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
            //set movie name
            self.movieTitleLabel.text = self.dataModelDic.title
            self.movieDescriptionLabel.text = self.dataModelDic.overview
        }
    }
}
