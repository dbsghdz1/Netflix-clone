//
//  Video.swift
//  NetflixClone
//
//  Created by 김윤홍 on 7/31/24.
//

import Foundation

struct VideoResponse: Codable {
  let results: [Video]
}

struct Video: Codable {
  let key: String
  let site: String
  let type: String
}
