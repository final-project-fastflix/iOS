//
//  OriginalTableCell.swift
//  Fastflix
//
//  Created by Jeon-heaji on 15/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//


import UIKit
import SnapKit
import Kingfisher

protocol OriginalTableCellDelegate: class {
  func originalDidSelectItemAt(indexPath: IndexPath)
}

final class OriginalTableCell: UITableViewCell {
  
  static let identifier = "OriginalTableCell"
  
  private let sectionHeaderlabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = "Netflix 오리지널 >"
    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    return label
  }()
  
  private let layout = UICollectionViewFlowLayout()
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  weak var delegate: OriginalTableCellDelegate?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .clear
    addSubViews()
    setupSNP()
    collectionviewSetUp()
    collectionView.register(OriginalCollectionCell.self, forCellWithReuseIdentifier: OriginalCollectionCell.identifier)
  }
  
  // MARK: - addSubViews
  private func addSubViews() {
    [collectionView, sectionHeaderlabel].forEach { self.addSubview($0)}
  }
  
  // MARK: - snapKitLayout
  private func setupSNP() {
    
    contentView.snp.makeConstraints {
      $0.height.equalTo(370)
    }
    
    sectionHeaderlabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalTo(10)
    }
    
    collectionView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.top.equalTo(sectionHeaderlabel.snp.bottom).offset(10)
    }
    
  }
  
  private func collectionviewSetUp() {
    layout.scrollDirection = .horizontal
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .clear
    self.collectionView.collectionViewLayout = layout
    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    layout.minimumLineSpacing = 7
    layout.minimumInteritemSpacing = 7
    layout.itemSize = CGSize(width: 170, height: 370)
    
    layout.sectionHeadersPinToVisibleBounds = true
    collectionView.showsHorizontalScrollIndicator = false
  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
extension OriginalTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ImagesData.shared.originalImages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OriginalCollectionCell.identifier, for: indexPath) as! OriginalCollectionCell
    cell.configure(imageUrlString: ImagesData.shared.originalImages[indexPath.row])
    return cell
  }
  
  
}

extension OriginalTableCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("indexPath.row: ", indexPath.row)
    delegate?.originalDidSelectItemAt(indexPath: indexPath)
    
  }
}

