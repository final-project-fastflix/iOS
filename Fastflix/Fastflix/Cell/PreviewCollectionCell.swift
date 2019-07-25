//
//  PriviewCollectionCell.swift
//  Fastflix
//
//  Created by Jeon-heaji on 12/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit

final class PreviewCollectionCell: UICollectionViewCell {
  
//  var myIndexpath: IndexPath? = nil
  
  static let identifier = "PreviewCollectionCell"
  
  private let preImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 55
    imageView.layer.borderWidth = 1.5
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.clipsToBounds = true
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  private let preImageLogo: UIImageView = {
    let logoImage = UIImageView()
    logoImage.image = UIImage(named: "preViewLogo")
    return logoImage
  }()
  
  private let blurImage: UIImageView = {
    let blurImage = UIImageView()
    blurImage.image = UIImage(named: "navshadow")
    return blurImage
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
//    addGesture()
    addSubViews()
    setupSNP()
    
  }
//
//  func addGesture() {
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handTapGesture(_:)))
//    preImageView.addGestureRecognizer(tapGesture)
//    preImageView.isUserInteractionEnabled = true
//  }
  
  func configure(imageName: String) {
    preImageView.image = UIImage(named: imageName)
  }
  
  // addSubViews
  private func addSubViews() {
    [preImageView,blurImage, preImageLogo].forEach { self.addSubview($0)}
    
  }
  
  private func setupSNP() {
    preImageView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.width.height.equalTo(110)
    }
    preImageLogo.snp.makeConstraints {
      $0.top.equalTo(preImageView.snp.bottom).inset(25)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(UIScreen.main.bounds.width / 4.5)
    }
    blurImage.snp.makeConstraints {
      $0.top.equalTo(preImageView.snp.bottom).inset(90)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(UIScreen.main.bounds.width)
    }
  }

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
