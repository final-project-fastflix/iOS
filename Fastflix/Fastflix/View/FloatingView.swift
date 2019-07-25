//
//  HomeView.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/10.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit

protocol FloatingViewDelegate: class {
  func didTapHome()
  func didTapMovie()
  func didTapPoke()
}

class FloatingView: UIView {
  
  weak var delegate: FloatingViewDelegate?
  
  let homeBtn: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "fastflixlogo1"), for: .normal)
    button.addTarget(self, action: #selector(homeBtnDidTap(_:)), for: .touchUpInside)
    return button
  }()
  
  let movieBtn: UIButton = {
    let button = UIButton()
    button.setTitle("영화", for: .normal)
    button.addTarget(self, action: #selector(movieBtnDidTap(_:)), for: .touchUpInside)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    return button
  }()
  
  let pokeBtn: UIButton = {
    let button = UIButton()
    button.setTitle("내가 찜한 콘텐츠", for: .normal)
    button.addTarget(self, action: #selector(pokeBtnDidTap(_:)), for: .touchUpInside)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubViews()
    setupSNP()
    
    self.backgroundColor = .clear
    
  }
  
  
  private func addSubViews() {
    
    [homeBtn, movieBtn, pokeBtn].forEach { self.addSubview($0) }
    
  }
  private func setupSNP() {
    
    homeBtn.snp.makeConstraints {
      $0.top.equalTo(UIScreen.main.bounds.height * 0.055)
      $0.width.height.equalTo(55)
      $0.leading.equalToSuperview().offset(10)
    }
    
    movieBtn.snp.makeConstraints {
      $0.top.equalTo(UIScreen.main.bounds.height * 0.07)
      $0.leading.equalTo(homeBtn.snp.trailing).offset(30)
    }
    
    pokeBtn.snp.makeConstraints {
      $0.top.equalTo(UIScreen.main.bounds.height * 0.07)
      $0.leading.equalTo(movieBtn.snp.trailing).offset(40)
    }
    
  }
  
  @objc func homeBtnDidTap(_ sender: UIButton) {
    print("homeBtnDidTap")
    delegate?.didTapHome()
  }
  
  @objc func movieBtnDidTap(_ sender: UIButton) {
    print("movieBtnDidTap")
    delegate?.didTapMovie()
  }
  
  @objc func pokeBtnDidTap(_ sender: UIButton) {
    print("pokeBtnDidTap")
    delegate?.didTapPoke()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
