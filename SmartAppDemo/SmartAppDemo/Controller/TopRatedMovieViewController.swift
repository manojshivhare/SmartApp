//
//  TopRatedMovieViewController.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 13/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import UIKit

class TopRatedMovieViewController: UIViewController {
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!

    var topRatedDataArr:[Results]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        ApiManager.shared.getUserData(urlStr: urlStr, view: self.view) { (responseData) in
            //print(responseData?.results as Any)
            self.topRatedDataArr = responseData?.results
            DispatchQueue.main.async {
                self.topRatedCollectionView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TopRatedMovieViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topRatedDataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCellIdentifier", for: indexPath as IndexPath) as! TopRatedCollectionViewCell
        
        cell.dataModelDic = topRatedDataArr![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return indexPath.item == 0 ? CGSize(width: 0, height: 0) : CGSize(width: 320, height:120)
    }
    
}
