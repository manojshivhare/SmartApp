//
//  LatestMovieViewController.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 13/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import UIKit

struct API {
    
    static let latestMovieUrlStr = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    static let topRatedMovieUrlStr = "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
}

class LatestMovieViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var latestMoviewCollectionView: UICollectionView!
    
    @IBOutlet weak var movieNameSearchBar: UISearchBar!
    
    var latestMoviewDataArr:[Results]?
    var latestMoviewDataDic:Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieNameSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        ApiManager.shared.getUserData(urlStr: API.latestMovieUrlStr, view: self.view) { (responseData) in
            //print(responseData as Any)
            self.latestMoviewDataArr = responseData?.results
            DispatchQueue.main.async {
                self.latestMoviewCollectionView.reloadData()
            }
        }
    }
    
    //MARK: SearchBar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == true {
            return
        }
//        let namePredicate = NSPredicate(format: "(title == %@)",searchText);
//        let filteredArray = latestMoviewDataArr!.filter { namePredicate.evaluate(with: $0) }
        
//        let filteredArray = latestMoviewDataArr!.filter( { (movie: Results) -> Bool in
//            return movie.title == searchText
//        })
        
        let filteredArray = latestMoviewDataArr!.filter {
            guard let name = $0.title else {
                return false
            }
            return name.contains(searchText)
        }
        
        print(filteredArray)
        //latestMoviewDataArr?.removeAll()
        latestMoviewDataArr = filteredArray
        latestMoviewCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "goToDetails" {
              let detailsVC = segue.destination as! MovieDetailsViewController
                detailsVC.dataModelDic = latestMoviewDataDic
          }
      }

}

extension LatestMovieViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.latestMoviewDataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestMovieIdentifier", for: indexPath as IndexPath) as! LatestMovieCollectionViewCell
        
        cell.dataModelDic = latestMoviewDataArr![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            latestMoviewDataDic = latestMoviewDataArr?[indexPath.item]
            self.performSegue(withIdentifier: "goToDetails", sender: nil)
    }
}
