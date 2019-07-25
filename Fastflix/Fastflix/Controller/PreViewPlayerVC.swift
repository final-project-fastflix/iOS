//
//  PreViewPlayerVC.swift
//  Fastflix
//
//  Created by Jeon-heaji on 15/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit
import AVKit

protocol PreViewPlayerVCDelegate {
  func finishVideo()
}

final class PreViewPlayerVC: UIViewController {
  
  private var delegate: PreViewPlayerVCDelegate?
  
  private let dismissBtn: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "x"), for: .normal)
    button.addTarget(self, action: #selector(dismissBtnDidTap(_:)), for: .touchUpInside)
    
    return button
  }()
  
  private let url = URL(string: preViewUrl)!
  
  
  private let playerViewController: AVPlayerViewController = {
    let playerVC = AVPlayerViewController()
    
    return playerVC
  }()
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    
    
    NotificationCenter.default.addObserver(self, selector: #selector(didFinishVideo(_:)), name: .AVPlayerItemDidPlayToEndTime, object: playerViewController.player?.currentItem)
    
    let player = AVPlayer(url: url)
    playerViewController.player = player
    present(playerViewController, animated: true) {
      player.play()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(dismissBtn)
    view.backgroundColor = .clear
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupSNP()
  }
  
  @objc func dismissBtnDidTap(_ sender: UIButton) {
    delegate?.finishVideo()
  }
  
  private func setupSNP() {
    dismissBtn.snp.makeConstraints {
      $0.top.equalTo(50)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(40)
    }
  }
  
  @objc func didFinishVideo(_ sender: NSNotification) {
    print("run")
    dismiss(animated: true)
  }
  
  
  
}
