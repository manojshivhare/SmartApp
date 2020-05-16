//
//  MovieDetailsViewController.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 15/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
        
    var dataModelDic: Results? {
        didSet {
            DispatchQueue.main.async {
                let imageURLStr = String(format: "https://image.tmdb.org/t/p/original%@",(self.dataModelDic?.poster_path!)!)

                ApiManager.shared.downloadImageFile(urlString: imageURLStr, success: { (image) in
                    DispatchQueue.main.async {
                        self.backgroundImageView.image = image
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
                self.descriptionTextView.text = self.dataModelDic?.overview
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
