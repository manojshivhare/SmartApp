//
//  TopRatedMovieViewController.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 13/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import UIKit

class TopRatedMovieViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    @IBOutlet weak var movieNameSearchBar: UISearchBar!
    

    var topRatedDataArr:[Results]?
    var topRatedDataDic:Results?

    override func viewDidLoad() {
        super.viewDidLoad()
        movieNameSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(true)
        
        ApiManager.shared.getUserData(urlStr: API.topRatedMovieUrlStr, view: self.view) { (responseData) in
            //print(responseData?.results as Any)
            self.topRatedDataArr = responseData?.results
            DispatchQueue.main.async {
                self.topRatedCollectionView.reloadData()
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
            
            let filteredArray = topRatedDataArr!.filter {
                guard let name = $0.title else {
                    return false
                }
                return name.contains(searchText)
            }
            
            print(filteredArray)
            //latestMoviewDataArr?.removeAll()
            topRatedDataArr = filteredArray
            topRatedCollectionView.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    

   // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "goToDetails" {
              let detailsVC = segue.destination as! MovieDetailsViewController
                detailsVC.dataModelDic = topRatedDataDic
          }
      }

}

extension TopRatedMovieViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topRatedDataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCellIdentifier", for: indexPath as IndexPath) as! TopRatedCollectionViewCell
        
        cell.dataModelDic = topRatedDataArr![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            topRatedDataDic = topRatedDataArr?[indexPath.item]
            self.performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
}
