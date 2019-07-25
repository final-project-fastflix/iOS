//
//  MainImageCell.swift
//  Fastflix
//
//  Created by Jeon-heaji on 11/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//
//
//  MainImageCell.swift
//  Fastflix
//
//  Created by Jeon-heaji on 11/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class MainImageTableCell: UITableViewCell {
  
  static let identifier = "MainImageTableCell" 
  
  private var stackView = UIStackView()
  private var textStackView = UIStackView()
  
  private let mainImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    return image
  }()
  
  private let logoImage: UIImageView = {
    let image = UIImageView()
    return image
  }()
  
   let movieDetailLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    return label
  }()
  
  private lazy var pokeButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "add"), for: .normal)
    button.setImage(UIImage(named: "poke"), for: .selected)
    button.addTarget(self, action: #selector(pokeBtnDidTap(_:)), for: .touchUpInside)
    return button
  }()
  
  private let playButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "play2"), for: .normal)
    return button
  }()
  
  private let infoButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "info"), for: .normal)
    return button
  }()
  
  private let textBelowPokeBtn: UILabel = {
    let text = UILabel()
    text.font = UIFont.systemFont(ofSize: 9, weight: .regular)
    text.textColor = .gray
    text.text = "내가 찜한 콘텐츠"
    text.textAlignment = .center
    return text
  }()
  
  private let textBelowinfoBtn: UILabel = {
    let text = UILabel()
    text.font = UIFont.systemFont(ofSize: 9, weight: .regular)
    text.textColor = .gray
    text.text = "정보"
    text.textAlignment = .center
    return text
  }()
  
  private let blurImage: UIImageView = {
    let blurImage = UIImageView()
    blurImage.image = UIImage(named: "navshadow")
    return blurImage
  }()

  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .clear
    setupStackView()
    addSubViews()
    setupSNP()
  }
  
  func configure(imageURLString: String?, logoImageURLString: String?) {
    let imageURL = URL(string: imageURLString ?? "ImagesData.shared.imagesUrl[5]")
    let logoImageURL = URL(string: logoImageURLString ?? "ImagesData.shared.imagesUrl[6]")
    
    self.mainImage.kf.setImage(with: imageURL, options: [.processor(CroppingImageProcessor(size: CGSize(width: 414, height: 600))), .scaleFactor(UIScreen.main.scale)])
    self.logoImage.kf.setImage(with: logoImageURL, options: [.processor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 200))), .cacheOriginalImage])
  }
  
  private func setupStackView() {
    // stackView
    stackView = UIStackView(arrangedSubviews: [pokeButton, playButton, infoButton])
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 50
    
    textStackView = UIStackView(arrangedSubviews: [textBelowPokeBtn, textBelowinfoBtn])
    textStackView.axis = .horizontal
    textStackView.distribution = .fillEqually
    textStackView.spacing = 205
  }
  
  
  // addSubViews
  private func addSubViews() {
    [mainImage, movieDetailLabel, logoImage, textStackView, stackView].forEach { self.addSubview($0)}
    insertSubview(blurImage, at: 2)
  }
  // snp
  private func setupSNP() {
    let appDelegate = AppDelegate.instance
    
    mainImage.snp.makeConstraints {
      $0.left.right.bottom.equalToSuperview()
      $0.top.equalToSuperview().offset(-topPadding)
      $0.height.equalTo(590)
    }
    
    logoImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.height.equalTo(UIScreen.main.bounds.width / 4)
      $0.width.equalTo(UIScreen.main.bounds.width / 1.8)
      $0.bottom.equalTo(movieDetailLabel.snp.top).offset(-20)
    }
    
    movieDetailLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.height.equalTo(30)
      $0.bottom.equalTo(stackView.snp.top).offset(-20)
    }
    
    blurImage.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.width.equalTo(800)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(UIScreen.main.bounds.height / 3)
    }
    
    stackView.snp.makeConstraints {
      $0.bottom.equalTo(textStackView.snp.top)
      $0.centerX.equalToSuperview()
    }
    
    textStackView.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-20)
      $0.centerX.equalToSuperview()
    }
  }
  
  @objc func pokeBtnDidTap(_ sender: UIButton) {
    UIView.animate(withDuration: 0.3) {
      self.pokeButton.alpha = 0
    }
    sender.isSelected.toggle()
    UIView.animate(withDuration: 0.3) {
      self.pokeButton.alpha = 1
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
