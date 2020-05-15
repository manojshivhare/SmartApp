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
            let imageURLStr = String(format: "https://image.tmdb.org/t/p/original/%@",self.dataModelDic.poster_path!)
            
            //download image from url
            self.getDataFromImageURL(from: URL(string:imageURLStr)!) { (image) in
                self.cellImageView.image = image
            }
            
            //set contact name
            self.cellTitleLabel.text = self.dataModelDic.title
            self.cellDescriptionLabel.text = self.dataModelDic.overview
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
