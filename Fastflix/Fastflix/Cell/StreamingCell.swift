//
//  StreamingCell.swift
//  TestCollectionViewFastflix
//
//  Created by hyeoktae kwon on 2019/07/15.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import AVKit
import SnapKit

class StreamingCell: UITableViewCell {
  
  static let identifier = "StreamingCell"
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.text = "절찬 스트리밍 중"
    label.textColor = .white
    return label
  }()
  
  private lazy var playBtn: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .white
    btn.setTitleColor(.black, for: .normal)
    btn.setTitle("재생", for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    btn.addTarget(self, action: #selector(didTapPlayBtn(_:)), for: .touchUpInside)
    return btn
  }()
  
  private lazy var pokeBtn: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .lightGray
    btn.setTitleColor(.white, for: .normal)
    btn.setTitle("+ 내가 찜한 콘텐츠", for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    btn.addTarget(self, action: #selector(didTapPokeBtn(_:)), for: .touchUpInside)
    return btn
  }()
  
  private lazy var muteBtn: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .black
    btn.alpha = 0.7
    btn.setImage(UIImage(named: "mute"), for: .normal)
    btn.setImage(UIImage(named: "sound"), for: .selected)
    btn.layer.cornerRadius = 13
    btn.addTarget(self, action: #selector(didTapMuteBtn(_:)), for: .touchUpInside)
    return btn
  }()
  
  private let degreeLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = #colorLiteral(red: 0.07762928299, green: 0.07762928299, blue: 0.07762928299, alpha: 1)
    label.text = "15"
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.textAlignment = .center
    label.layer.cornerRadius = 3
    return label
  }()
  
  let playerVC = AVPlayerViewController()
  var player: AVPlayer?
  
  
  
  private func setupPlayer(url: String) {
    player = AVPlayer(url: URL(string: url)!)
    playerVC.player = player
    playerVC.player?.play()
    playerVC.player?.isMuted = true
    playerVC.showsPlaybackControls = false
    [muteBtn, degreeLabel].forEach { playerVC.view.bringSubviewToFront($0) }
  }
  
  func configure(url: String) {
    setupPlayer(url: url)
    self.backgroundColor = #colorLiteral(red: 0.07762928299, green: 0.07762928299, blue: 0.07762928299, alpha: 1)
  }
  
  @objc private func didTapMuteBtn(_ sender: UIButton) {
    muteBtn.isSelected.toggle()
    playerVC.player?.isMuted.toggle()
  }
  
  @objc private func didTapPlayBtn(_ sender: UIButton) {
    print("didTapPlayBtn")
  }
  
  @objc private func didTapPokeBtn(_ sender: UIButton) {
    print("didTapPokeBtn")
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    setupAutoLayout()
  }
  
  private func setupAutoLayout() {
    
    [playerVC.view, titleLabel, pokeBtn, playBtn].forEach { addSubview($0) }
    [muteBtn, degreeLabel].forEach { playerVC.view.addSubview($0) }
    
    self.contentView.snp.makeConstraints {
      $0.height.equalTo(320)
      $0.width.equalToSuperview()
    }
    
    muteBtn.snp.makeConstraints {
      $0.width.height.equalTo(26)
      $0.trailing.bottom.equalToSuperview().inset(15)
    }
    
    degreeLabel.snp.makeConstraints {
      $0.width.height.equalTo(26)
      $0.leading.bottom.equalToSuperview().inset(15)
    }
    
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(10)
      $0.top.equalToSuperview().offset(20)
    }
    
    playerVC.view.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(titleLabel.snp.bottom).offset(5)
    }
    
    playBtn.snp.makeConstraints {
      $0.leading.bottom.equalToSuperview().offset(10)
      $0.top.equalTo(playerVC.view.snp.bottom).offset(10)
      $0.trailing.equalTo(contentView.snp.centerX).offset(-5)
    }
    
    pokeBtn.snp.makeConstraints {
      $0.leading.equalTo(contentView.snp.centerX).offset(5)
      $0.centerY.equalTo(playBtn)
      $0.trailing.equalToSuperview().offset(-10)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
