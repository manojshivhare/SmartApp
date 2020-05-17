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
    var latestMoviewFilterDataArr:[Results]?
    var latestMoviewDataDic:Results?
    var isDataFiltered = Bool()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        movieNameSearchBar.delegate = self
        latestMoviewCollectionView.collectionViewLayout = createCollectionViewLayout()
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
    
    //MARK: Make Compositional Layout
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        // Define Item Size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))


        // Create Item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Define Group Size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150.0))

        // Create Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [ item ])

        // Create Section
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    //MARK: SearchBar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == true {
            isDataFiltered = false
            latestMoviewCollectionView.reloadData()
            return
        }
        
        let filteredArray = latestMoviewDataArr!.filter {
            guard let name = $0.title else {
                return false
            }
            return name.contains(searchText)
        }
        
        if filteredArray.count > 0 {
            isDataFiltered = true
            latestMoviewFilterDataArr = filteredArray
            latestMoviewCollectionView.reloadData()
        }
        
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
        if isDataFiltered {
            return latestMoviewFilterDataArr!.count
        }
        else{
            return self.latestMoviewDataArr?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestMovieIdentifier", for: indexPath as IndexPath) as! LatestMovieCollectionViewCell
        
        if isDataFiltered {
            cell.dataModelDic = latestMoviewFilterDataArr![indexPath.row]
        }
        else
        {
            cell.dataModelDic = latestMoviewDataArr![indexPath.row]
        }

        cell.movieDeleteBtn.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        cell.movieDeleteBtn.tag = indexPath.item
        return cell
    }
    
    //MARK: Selector Method Action
    @objc func deleteCell(sender:UIButton){
        self.latestMoviewDataArr?.remove(at: sender.tag)
        latestMoviewCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        latestMoviewDataDic = latestMoviewDataArr?[indexPath.item]
        self.performSegue(withIdentifier: "goToDetails", sender: nil)
    }

}
