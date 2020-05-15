//
//  NetworkManager.swift
//  Go-JekAssesmentTest
//
//  Created by Manoj Shivhare on 14/05/20.
//  Copyright © 2019 Droom. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    let session = URLSession(configuration: .default)
    var request : NSMutableURLRequest = NSMutableURLRequest()
    var activityIndicator : UIActivityIndicatorView?
    
    func getUserData(urlStr:String,view:UIView,_ complition: @escaping (MovieModel?)->()) {
        
        guard let url = URL(string: urlStr) else {return}
        request.url = url
        request.httpMethod = "GET"
        request.timeoutInterval = 100
        showProgressView(in: view)
        let task = session.dataTask(with: url) { (data, response, error) in
            self.hideProgressView()
            guard let userData = data, error == nil else  {
                print(error?.localizedDescription ?? "Response error")
                return
            }
            
            let userDic = try? JSONDecoder().decode(MovieModel.self, from: userData)
            complition(userDic)
        }
        task.resume()
    }
    
    //MARK: Show Progress View
    func showProgressView(in view:UIView) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.frame = view.bounds
        if let progressBar = activityIndicator{
            view.addSubview(progressBar)
        }
        activityIndicator?.startAnimating()
    }
    
    //MARK: Hide Progress View
    func hideProgressView() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.removeFromSuperview()
        }
    }
    
}

