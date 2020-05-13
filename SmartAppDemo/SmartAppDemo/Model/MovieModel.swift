//
//  MovieModel.swift
//  SmartAppDemo
//
//  Created by Manoj Shivhare on 13/05/20.
//  Copyright © 2020 Manoj Shivhare. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    let results:[Results]
}

struct Results: Codable {
    
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let poster_path: String
    let id: Int
    let adult:Bool
    let backdrop_path:String
    let original_language:String
    let original_title:String
    let title: String
    let vote_average:Double
    let overview:String
    let release_date: String
}


