//
//  LatestMovieViewController.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 13/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import UIKit

class LatestMovieViewController: UIViewController {
    
    @IBOutlet weak var latestMoviewCollectionView: UICollectionView!
    
    var latestMoviewDataArr:[Results]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"

        ApiManager.shared.getUserData(urlStr: urlStr, view: self.view) { (responseData) in
            //print(responseData as Any)
            self.latestMoviewDataArr = responseData?.results
            DispatchQueue.main.async {
                self.latestMoviewCollectionView.reloadData()
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

extension LatestMovieViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.latestMoviewDataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestMovieIdentifier", for: indexPath as IndexPath) as! LatestMovieCollectionViewCell
        
        cell.dataModelDic = latestMoviewDataArr![indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        return CGSize(width: 320, height:120)
//    }
    
}
