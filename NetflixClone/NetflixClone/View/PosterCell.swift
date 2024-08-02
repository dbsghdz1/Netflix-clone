//
//  PosterCell.swift
//  NetflixClone
//
//  Created by 김윤홍 on 8/1/24.
//

import UIKit

class PosterCell: UICollectionViewCell {
  static let id = "posterCell"
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = .darkGray
    imageView.layer.cornerRadius = 10
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    imageView.frame = contentView.bounds
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with movie: Movie) {
    guard let poster_path = movie.poster_path else { return }
    let urlString = "https://image.tmdb.org/t/p/w500/\(poster_path).jpg"
    guard let url = URL(string: urlString) else { return }
    
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.imageView.image = image
          }
        }
      }
    }
  }
}
