//
//  ProfileChangeVC.swift
//  Fastflix
//
//  Created by HongWeonpyo on 25/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class ProfileChangeVC: UIViewController {

  let subUserSingle = SubUserSingleton.shared
  
  // 네이게이션뷰
  lazy var navigationView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.addSubview(profileChangeLabel)
    view.addSubview(saveButton)
    view.addSubview(cancelButton)
    return view
  }()
  
  // 프로필관리 레이블(edit할때 나타나는 label)
  let profileChangeLabel: UILabel = {
    let label = UILabel()
//    label.text = "프로필 변경"
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 17)
    return label
  }()
  
  // 저장 버튼
  lazy var saveButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("저장", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
    return button
  }()
  
  // 취소 버튼
  lazy var cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("취소", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
    return button
  }()
  
  var userView = UserView()
  
  let textSurroundingView: UIView = {
    let view = UIView()
    view.layer.borderWidth = 1
    view.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    return view
  }()
  
  var subUserNameTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = .black
    tf.textColor = .white
    tf.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    return tf
  }()
  
  let kidsLabel: UILabel = {
    let label = UILabel()
    label.text = "키즈용"
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 17)
    return label
  }()
  
  let kidsSwitchButton: UISwitch = {
    let switchButton = UISwitch()
    return switchButton
  }()
  
  lazy var kidsStackView: UIStackView = {
    var sv = UIStackView(arrangedSubviews: [kidsLabel, kidsSwitchButton])
    sv.spacing = 15
    sv.axis = .horizontal
    sv.distribution = .fill
    sv.isHidden = true
    return sv
  }()
  
  let deleteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("삭제", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
    return button
  }()
  
  var userName: String?
  
  var userImage: UIImage?
  
  var isUserCreating: Bool?
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    addSubViews()
    navigationBarSetting()
    setFuntions()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupSNP()
    kidsStackView.isHidden = false
    subUserNameTextField.becomeFirstResponder()
  }
  
  private func configure() {
//    view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    view.backgroundColor = .black
    userView.profileUserName = "변경"
    subUserNameTextField.text = userName ?? ""
    userView.imageView.image = userImage ?? UIImage(named: "profile1")
    profileChangeLabel.text = isUserCreating == false ? "프로필 변경" : "프로필 만들기"
    subUserNameTextField.delegate = self
  }
  
  private func addSubViews() {
    [navigationView, userView, textSurroundingView, subUserNameTextField, kidsStackView, deleteButton].forEach { view.addSubview($0) }
  }
  
  private func setupSNP() {
    
    navigationView.snp.makeConstraints {
      $0.top.equalTo(view.snp.top)
      $0.leading.equalTo(view.snp.leading)
      $0.trailing.equalTo(view.snp.trailing)
      $0.height.equalTo(UIScreen.main.bounds.height * 0.11)
    }
    
    profileChangeLabel.snp.makeConstraints {
      $0.bottom.equalTo(navigationView.snp.bottom).offset(8)
      $0.centerX.equalTo(navigationView.snp.centerX)
      $0.width.equalToSuperview().multipliedBy(0.25)
      $0.height.equalTo(profileChangeLabel.snp.width).multipliedBy(0.70)
    }
    
    saveButton.snp.makeConstraints {
      $0.centerY.equalTo(profileChangeLabel.snp.centerY)
      $0.trailing.equalTo(view.snp.trailing).offset(-15)
    }
    
    cancelButton.snp.makeConstraints {
      $0.centerY.equalTo(profileChangeLabel.snp.centerY)
      $0.leading.equalTo(view.snp.leading).offset(15)
    }
    
    userView.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width * 0.28)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(navigationView.snp.bottom).offset(40)
    }
    
    textSurroundingView.snp.makeConstraints {
      $0.top.equalTo(userView.snp.bottom).offset(30)
      $0.leading.trailing.equalToSuperview().inset(45)
      $0.height.equalTo(45)
    }
    
    subUserNameTextField.snp.makeConstraints {
      $0.top.bottom.equalTo(textSurroundingView).inset(5)
      $0.leading.trailing.equalTo(textSurroundingView).inset(10)
    }
    
    kidsStackView.snp.makeConstraints {
      $0.top.equalTo(textSurroundingView.snp.bottom).offset(30)
      $0.centerX.equalTo(textSurroundingView.snp.centerX)
    }
    
    deleteButton.snp.makeConstraints {
      $0.top.equalTo(kidsStackView.snp.bottom).offset(30)
      $0.centerX.equalTo(textSurroundingView.snp.centerX)
    }
    
  }
  
  private func navigationBarSetting() {
    let navCon = navigationController!
    navCon.isNavigationBarHidden = true
  }
  
  @objc private func saveButtonTapped(_ sender: UIButton) {
    print("새로바뀐 유저정보 저장관련 메서드 넣어야함")
    saveChangedUserInfo()
    dismiss(animated: true)
  }
  
  private func saveChangedUserInfo() {
    guard let name = subUserNameTextField.text else { return }
    let kid = kidsSwitchButton.isOn ? true : false
    
    if isUserCreating! {
      APICenter.shared.createSubUser(name: name, kid: kid) {
        switch $0 {
        case .success(let subUsers):
          print("User Creating Success!!!")
          print("value: ", subUsers)
          
          self.subUserSingle.subUserList = subUsers
//          profileSelectVC.numberOfUsers = value.count
//          profileSelectVC.subUserList = value
          
//          self.dismiss(animated: true, completion: {
//          })
          
        case .failure(let err):
          print("fail to login, reason: ", err)
        }
      }
    }
    
    
  }
  
  
  @objc private func cancelButtonTapped(_ sender: UIButton) {
    print("취소")
    dismiss(animated: true)
  }
  
  @objc private func deleteButtonTapped(_ sender: UIButton) {
    print("삭제 누름")
    
    alert(title: "프로필 삭제", message: "이 프로필을 삭제하시겠어요?") {
      //프로필 삭제시 - 클로저로 기능 구현 코드 넣어야 함
  
    }
    
    //삭제버튼 눌렀을때 Alert화면 구현
//    let alert = UIAlertController(title: "프로필 삭제", message: "이 프로필을 삭제하시겠어요?", preferredStyle: .alert)
//    let cencelAction = UIAlertAction(title: "아니요", style: .default, handler: nil)
//    let oKaction = UIAlertAction(title: "예", style: .default) { _ in
//      // 여기에 유저 삭제에 관한 메서드 구현해야함
//      self.dismiss(animated: true)
//    }
//
//    alert.addAction(cencelAction)
//    alert.addAction(oKaction)
//
//    present(alert, animated: true, completion: nil)
    
  }
  
  // 텍스트필드에 아무것도 없으면 저장 버튼 비활성화
  @objc private func editingChanged(_ textField: UITextField) {
    if textField.text?.count == 1 {
      if textField.text?.first == " " {
        textField.text = ""
        return
      }
    }
    guard
      let username = subUserNameTextField.text, !username.isEmpty
      else {
        saveButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
        saveButton.isEnabled = false
        return
    }
    saveButton.setTitleColor(.white, for: .normal)
    saveButton.isEnabled = true
  }
}


extension ProfileChangeVC: UserViewDelegate {
  func profileChangeTapped(tag: Int, userName: String, userImage: UIImage) {
  }
  
  private func setFuntions() {
    userView.delegate = self
  }
  
  func didSelectUser(tag: Int) {
    
    print("여러가지 프로필 선택 화면으로 이동--->")
    
  }
}

extension ProfileChangeVC: UITextFieldDelegate {
  
  //프로필 추가시에는 시작부터 텍스트 없기 때문에 버튼 비활성화 시키키 위해 텍스트필드 메서드 이용
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.text?.count == 1 {
      if textField.text?.first == " " {
        textField.text = ""
        return
      }
    }
    guard
      let username = subUserNameTextField.text, !username.isEmpty
      else {
        saveButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
        saveButton.isEnabled = false
        return
    }
    saveButton.setTitleColor(.white, for: .normal)
    saveButton.isEnabled = true
  }
}
