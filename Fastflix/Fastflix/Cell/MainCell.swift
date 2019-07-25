//
//  MainCell.swift
//  TestCollectionViewFastflix
//
//  Created by hyeoktae kwon on 2019/07/13.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
  
  static let identifier = "MainCell"
  
  private var urls: [URL?]?
  
  private let layout = UICollectionViewFlowLayout()
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.backgroundColor = #colorLiteral(red: 0.07762928299, green: 0.07762928299, blue: 0.07762928299, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  func configure(url: [String]?, title: String?) {
    let urlArr = url ?? imageUrls
    let title = title ?? "title"
    
    self.urls = urlArr.map { URL(string: $0) }
    self.titleLabel.text = title
    self.backgroundColor = #colorLiteral(red: 0.07762928299, green: 0.07762928299, blue: 0.07762928299, alpha: 1)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    [collectionView, titleLabel].forEach { addSubview($0) }
    
    layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    layout.minimumLineSpacing = 15
    layout.minimumInteritemSpacing = 15
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.height / 4.8)
    layout.scrollDirection = .horizontal
    
    collectionView.register(
      ImageCell.self,
      forCellWithReuseIdentifier: ImageCell.identifier)
    
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = #colorLiteral(red: 0.07762928299, green: 0.07762928299, blue: 0.07762928299, alpha: 1)
    collectionView.dataSource = self
    setupSNP()
  }
  
  private func setupSNP() {
    
    contentView.snp.makeConstraints {
      $0.height.equalTo(220)
    }
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(10)
      $0.top.equalToSuperview().offset(10)
    }
    
    collectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(titleLabel.snp.bottom).offset(5)
      $0.bottom.equalToSuperview().offset(-10)
    }
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

extension MainCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return urls?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
    
    cell.configure(url: urls?[indexPath.row])
    
    return cell
  }
  
}
