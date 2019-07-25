//
//  ImageCell.swift
//  TestCollectionViewFastflix
//
//  Created by hyeoktae kwon on 2019/07/13.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

final class ImageCell: UICollectionViewCell {
  static let identifier = "ImageCell"
  
  private let imageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.backgroundColor = #colorLiteral(red: 0.07762928299, green: 0.07762928299, blue: 0.07762928299, alpha: 1)
    img.clipsToBounds = true
    return img
  }()
  
  func configure(url: URL?) {
    imageView.kf.setImage(with: url, options: [.processor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 200))), .cacheOriginalImage])
//    imageView.kf.setImage(with: url, placeholder: Placeholder, options: <#T##KingfisherOptionsInfo?#>, progressBlock: <#T##DownloadProgressBlock?##DownloadProgressBlock?##(Int64, Int64) -> Void#>, completionHandler: <#T##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##(Result<RetrieveImageResult, KingfisherError>) -> Void#>)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    [imageView].forEach { addSubview($0) }
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
  
}
