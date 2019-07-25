//
//  ProfileView.swift
//  Fastflix
//
//  Created by Jeon-heaji on 22/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit

protocol CreateProfileViewDelegate {
  func cancelBtndidTap(button: UIButton)
  func titleImageChange(button: UIButton)
}

class CreateProfileView: UIView {
  
  
  var delegate: CreateProfileViewDelegate?
  
  let cancelBtn: UIButton = {
    let button = UIButton()
    button.setTitle("취소", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(cancelBtnDidTap(_:)), for: .touchUpInside)
    button.setTitleShadowColor(.gray, for: .normal)
    return button
  }()
  
  let profileLable: UILabel = {
    let label = UILabel()
    label.text = "프로필 만들기"
    label.textColor = .white
    return label
  }()
  
  let saveBtn: UIButton = {
    let button = UIButton()
    button.setTitle("저장", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    button.addTarget(self, action: #selector(saveBtnDidTap(_:)), for: .touchUpInside)
    return button
  }()
  
  let titleImageBtn: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "profile5"), for: .normal)
    button.addTarget(self, action: #selector(titleImageBtnDidTap(_:)), for: .touchUpInside)
    return button
  }()
  
  let changeBtn: UIButton = {
    let button = UIButton()
    button.setTitle("변경", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(titleImageBtnDidTap(_:)), for: .touchUpInside)
    return button
  }()
  
  let profileNameTextfield: UITextField = {
    let textfield = UITextField()
    textfield.textColor = .white
    textfield.layer.borderColor = UIColor.white.cgColor
    textfield.layer.borderWidth = 1
    textfield.layer.cornerRadius = 0
    textfield.placeholder = "입력하세요"
    textfield.textAlignment = .center
    return textfield
  }()
  
  let kidsLabel: UILabel = {
    let label = UILabel()
    label.text = "키즈용"
    label.textColor = .white
    return label
  }()
  
  let kidsSwitch = UISwitch()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews()
    setupAutoLayout()
    attribute()
    
  }
  private func addSubviews() {
    [cancelBtn, profileLable,saveBtn,titleImageBtn, changeBtn, profileNameTextfield, kidsLabel, kidsSwitch] .forEach { self.addSubview($0) }
  }
  private func setupAutoLayout() {
    cancelBtn.snp.makeConstraints {
      $0.top.equalTo(UIScreen.main.bounds.height * 0.04)
      $0.leading.equalToSuperview().inset(30)
    }
    profileLable.snp.makeConstraints {
      $0.top.equalTo(UIScreen.main.bounds.height * 0.05)
      $0.centerX.equalToSuperview()
      
    }
    saveBtn.snp.makeConstraints {
      $0.top.equalTo(UIScreen.main.bounds.height * 0.04)
      $0.trailing.equalToSuperview().inset(30)
    }
    
    titleImageBtn.snp.makeConstraints {
      $0.top.equalTo(profileLable.snp.bottom).offset(95)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(UIScreen.main.bounds.width * 0.28)
    }
    changeBtn.snp.makeConstraints {
      $0.top.equalTo(titleImageBtn.snp.bottom).offset(15)
      $0.centerX.equalToSuperview()
    }
    
    profileNameTextfield.snp.makeConstraints {
      $0.top.equalTo(changeBtn.snp.bottom).offset(30)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(45)
      $0.leading.trailing.equalToSuperview().inset(55)
    }
    kidsLabel.snp.makeConstraints {
      $0.top.equalTo(profileNameTextfield.snp.bottom).offset(20)
      $0.centerX.equalToSuperview().offset(-25)
    }
    kidsSwitch.snp.makeConstraints {
      $0.top.equalTo(profileNameTextfield.snp.bottom).offset(15)
      $0.leading.equalTo(kidsLabel.snp.trailing).offset(10)
    }
    
  }
  private func attribute() {
    profileNameTextfield.delegate = self
    profileNameTextfield.becomeFirstResponder()
    
  }
  
  @objc func cancelBtnDidTap(_ sender: UIButton) {
    delegate?.cancelBtndidTap(button: sender)
  }
  @objc func saveBtnDidTap(_ sender: UIButton) {
    sender.isSelected.toggle()
  }
  
  @objc func titleImageBtnDidTap(_ sender: UIButton) {
    delegate?.titleImageChange(button: sender)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CreateProfileView: UITextFieldDelegate {
  
}
