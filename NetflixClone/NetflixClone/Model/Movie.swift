//
//  Movie.swift
//  NetflixClone
//
//  Created by 김윤홍 on 7/31/24.
//

import Foundation

struct MovieData: Codable {
  let results: [Movie]
}

struct Movie: Codable {
  let id: Int?
  let title: String?
  let posterPath: String?
  
  enum CodingKeys: String, CodingKey {
    case id, title
    case posterPath = "poster_path"
  }
}
