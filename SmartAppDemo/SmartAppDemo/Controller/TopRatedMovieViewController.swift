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
    var topRatedFilterDataArr:[Results]?
    var topRatedDataDic:Results?
    var isDataFiltered = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieNameSearchBar.delegate = self
        topRatedCollectionView.collectionViewLayout = createCollectionViewLayout()
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
            topRatedCollectionView.reloadData()
            return
        }
        
        let filteredArray = topRatedDataArr!.filter {
            guard let name = $0.title else {
                return false
            }
            return name.contains(searchText)
        }
        
        if filteredArray.count > 0 {
            isDataFiltered = true
            topRatedFilterDataArr = filteredArray
            topRatedCollectionView.reloadData()
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
            detailsVC.dataModelDic = topRatedDataDic
        }
    }
    
}

extension TopRatedMovieViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isDataFiltered {
            return self.topRatedFilterDataArr!.count
       }
       else{
           return self.topRatedDataArr?.count ?? 0
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCellIdentifier", for: indexPath as IndexPath) as! TopRatedCollectionViewCell
        
        if isDataFiltered {
            cell.dataModelDic = topRatedFilterDataArr![indexPath.row]
        }
        else
        {
            cell.dataModelDic = topRatedDataArr![indexPath.row]
        }

        cell.cellDeleteBtn.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        cell.cellDeleteBtn.tag = indexPath.item        
        return cell
    }
    
    //MARK: Selector Method Action
      @objc func deleteCell(sender:UIButton){
          self.topRatedDataArr?.remove(at: sender.tag)
          topRatedCollectionView.reloadData()
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        topRatedDataDic = topRatedDataArr?[indexPath.item]
        self.performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
}
