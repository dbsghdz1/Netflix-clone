//
//  SectionHeaderView.swift
//  NetflixClone
//
//  Created by 김윤홍 on 8/1/24.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
  static let id = "sectionHeaderView"
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = .white
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
    ])
  }
  
  func configure(with title: String) {
    titleLabel.text = title
  }
}