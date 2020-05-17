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
    
//    var cellLabel: UILabel!
//    var pan: UIPanGestureRecognizer!
//    var deleteLabel1: UILabel!
//    var deleteLabel2: UILabel!
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    private func commonInit() {
//        self.contentView.backgroundColor = UIColor.init(red: 235.0/255.0, green: 172.0/255.0, blue: 75.0/255.0, alpha: 1.0)
//        self.backgroundColor = UIColor.red
//
//        cellLabel = UILabel()
//        cellLabel.textColor = UIColor.white
//        cellLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.addSubview(cellLabel)
//        cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//        cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
//        cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
//        cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
//
//        deleteLabel1 = UILabel()
//        deleteLabel1.text = "delete"
//        deleteLabel1.textColor = UIColor.white
//        self.insertSubview(deleteLabel1, belowSubview: self.contentView)
//
//        deleteLabel2 = UILabel()
//        deleteLabel2.text = "delete"
//        deleteLabel2.textColor = UIColor.white
//        self.insertSubview(deleteLabel2, belowSubview: self.contentView)
//
//        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
//        pan.delegate = self
//        self.addGestureRecognizer(pan)
//    }
//
//    override func layoutSubviews() {
//       super.layoutSubviews()
//
//        if (pan.state == .changed) {
//         let p: CGPoint = pan.translation(in: self)
//         let width = self.contentView.frame.width
//         let height = self.contentView.frame.height
//         self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
//         self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 100, height: height)
//         self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
//       }
//
//     }
//
//    @objc func onPan(_ pan: UIPanGestureRecognizer) {
//       if pan.state == .began {
//
//       } else if pan.state == .changed {
//         self.setNeedsLayout()
//       } else {
//         if abs(pan.velocity(in: self).x) > 500 {
//           let collectionView: UICollectionView = self.superview as! UICollectionView
//           let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
//            print(indexPath.item)
//            collectionView.performBatchUpdates({
//
//                // Perform this in reverse to maintain correct indices
//                print(self.dataModelArr?.count as Any)
//                self.dataModelArr?.remove(at: indexPath.item)
//                print(self.dataModelArr?.count as Any)
//                collectionView.deleteItems(at:[(NSIndexPath(item: indexPath.item, section: 0) as IndexPath)])
//                collectionView.reloadData()
//            }, completion: nil)
//
//         } else {
//           UIView.animate(withDuration: 0.2, animations: {
//             self.setNeedsLayout()
//             self.layoutIfNeeded()
//           })
//         }
//       }
//     }
    
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
