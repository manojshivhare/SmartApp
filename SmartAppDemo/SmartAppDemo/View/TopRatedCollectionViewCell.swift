//
//  TopRatedCollectionViewCell.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 15/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import UIKit

class TopRatedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    @IBOutlet weak var cellDescriptionLabel: UILabel!
    
    
    //Set up value into outlet
    var dataModelDic: Results! {
        didSet {
            let imageURLStr = String(format: "https://image.tmdb.org/t/p/w342%@",self.dataModelDic.poster_path!)
            
            //download image from url
            ApiManager.shared.downloadImageFile(urlString: imageURLStr, success: { (image) in
                DispatchQueue.main.async {
                      self.cellImageView.image = image
                  }
            }) { (error) in
                print(error.localizedDescription)
            }
            
            //set movie name
            self.cellTitleLabel.text = self.dataModelDic.title
            self.cellDescriptionLabel.text = self.dataModelDic.overview
        }
    }
    
}
