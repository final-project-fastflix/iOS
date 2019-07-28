//
//  LoginVC.swift
//  Fastflix
//
//  Created by HongWeonpyo on 20/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
  // 네이게이션뷰
  lazy var navigationView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.addSubview(logoView)
    view.addSubview(customerCenterButton)
    view.addSubview(backButton)
    return view
  }()
  
  // 네비게이션 - 로고
  let logoView: UIImageView = {
    let image = UIImage(named: "fastflix")
    let view = UIImageView()
    view.image = image
    view.contentMode = .scaleToFill
    return view
  }()
  
  // 고객센터 버튼
  lazy var customerCenterButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("고객 센터", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(customerCenterTapped(_:)), for: .touchUpInside)
    return button
  }()
  
  // 뒤로가기 버튼
  lazy var backButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: "back")
    button.setImage(image, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.tintColor = .white
    button.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    return button
  }()
  
  // 로그인 - 이메일 입력 필드
  lazy var emailTextField: UITextField = {
    var tf = UITextField()
    tf.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    tf.layer.cornerRadius = 5
    tf.attributedPlaceholder
      = NSAttributedString(string: "  이메일 주소 또는 전화번호",attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
    tf.textColor = .white
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.keyboardType = .emailAddress
    tf.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    tf.keyboardAppearance = .dark
    return tf
  }()
  
  // 로그인 - 비밀번호 입력 필드
  let passwordField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    tf.attributedPlaceholder
      = NSAttributedString(string: "  비밀번호",attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
    tf.layer.cornerRadius = 5
    tf.textColor = .white
    tf.autocapitalizationType = .none
    tf.autocorrectionType = .no
    tf.spellCheckingType = .no
    tf.isSecureTextEntry = true
    tf.clearsOnBeginEditing = false
    tf.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    tf.keyboardAppearance = .dark
    return tf
  }()
  
  // 로그인버튼
  let loginButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.layer.cornerRadius = 5
    button.layer.borderWidth = 1
    button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    button.setTitle("로그인", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.addTarget(self, action: #selector(didTapLoginBtn(_:)), for: .touchUpInside)
    button.isEnabled = false
    return button
  }()
  
  // 이메일텍스트필드, 패스워드, 로그인버튼 스택뷰에 배치
  lazy var stackView: UIStackView = {
    let sview = UIStackView(arrangedSubviews: [emailTextField, passwordField, loginButton])
    sview.spacing = 18
    sview.axis = .vertical
    sview.distribution = .fill
    return sview
  }()
  
  // 비밀번호 재설정 버튼
  let passwordButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.setTitle("비밀번호 재설정", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    return button
  }()
  
  let viewHeight: CGFloat = 48
  
  // 스태터스바 글씨 하얗게 설정
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    navigationBarSetting()
    addSubViews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupSNP()
  }
  
  private func configure() {
    view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
    emailTextField.delegate = self
    passwordField.delegate = self
  }
  
  private func addSubViews() {
    
    [navigationView, stackView, passwordButton].forEach { view.addSubview($0)}
    
  }
  
  private func setupSNP() {
    
    emailTextField.snp.makeConstraints {
      $0.height.equalTo(viewHeight)
    }
    
    passwordField.snp.makeConstraints {
      $0.height.equalTo(viewHeight)
    }
    
    loginButton.snp.makeConstraints {
      $0.height.equalTo(viewHeight)
    }
    
    stackView.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
      $0.leading.equalTo(view.snp.leading).offset(30)
      $0.trailing.equalTo(view.snp.trailing).offset(-30)
    }
    
    passwordButton.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom).offset(10)
      $0.leading.equalTo(view.snp.leading).offset(30)
      $0.trailing.equalTo(view.snp.trailing).offset(-30)
      $0.height.equalTo(viewHeight)
    }
    
    navigationView.snp.makeConstraints {
      $0.top.equalTo(view.snp.top)
      $0.leading.equalTo(view.snp.leading)
      $0.trailing.equalTo(view.snp.trailing)
      $0.height.equalTo(UIScreen.main.bounds.height * 0.11)
    }
    
    logoView.snp.makeConstraints {
      $0.bottom.equalTo(navigationView.snp.bottom).offset(8)
      $0.centerX.equalTo(navigationView.snp.centerX)
      $0.width.equalToSuperview().multipliedBy(0.25)
      $0.height.equalTo(logoView.snp.width).multipliedBy(0.70)
    }
    
    customerCenterButton.snp.makeConstraints {
      $0.centerY.equalTo(logoView.snp.centerY)
      $0.trailing.equalTo(view.snp.trailing).offset(-15)
    }
    
    backButton.snp.makeConstraints {
      $0.centerY.equalTo(logoView.snp.centerY)
      $0.width.height.equalTo(14)
      $0.leading.equalTo(view.snp.leading).offset(20)
    }
  }
  
  // 네비게이션바 세팅
  private func navigationBarSetting() {
    let navCon = navigationController!
    navCon.isNavigationBarHidden = true
  }
  
  // 로그인버튼 눌렀을 때
  @objc private func didTapLoginBtn(_ sender: UIButton) {
    guard let id = emailTextField.text, let pw = passwordField.text else { return }
    APICenter.shared.login(id: id, pw: pw) {
      switch $0 {
      case .success(let value):
        print("Login Success!!!")
        print("value: ", value)

//        DispatchQueue.main.async {
//          AppDelegate.instance.checkLoginState()
//        }
        
        let profileSelectVC = ProfileSelectVC()
        let navi = UINavigationController(rootViewController: profileSelectVC)
        profileSelectVC.numberOfUsers = value.count
        profileSelectVC.subUserList = value
        
        self.present(navi, animated: false)
        
      case .failure(let err):
        print("fail to login, reason: ", err)
      }
      
    }
  }
  
  // 고객센터버튼 눌렀을 때
  @objc private func customerCenterTapped(_ sender: UIButton) {
    let customerCenterVC = CustomerCenterVC()
    present(customerCenterVC, animated: true)
  }
  
  // 뒤로가기 버튼을 눌렀을 때
  @objc private func backButtonTapped(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  // 이메일텍스트필드, 비밀번호 텍스트필드 두가지 다 채워져 있을때, 로그인 버튼 빨간색으로 변경
  @objc private func editingChanged(_ textField: UITextField) {
    if textField.text?.count == 1 {
      if textField.text?.first == " " {
        textField.text = ""
        return
      }
    }
    guard
      let email = emailTextField.text, !email.isEmpty,
      let password = passwordField.text, !password.isEmpty
      else {
        loginButton.backgroundColor = .clear
        loginButton.isEnabled = false
        return
    }
    loginButton.backgroundColor = .red
    loginButton.isEnabled = true
  }
}

// 텍스트필드 델리게이트 구현
extension LoginVC: UITextFieldDelegate {
  // 텍스트필드 편집 시작하면 백그라운드 색 변경
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
  }
  
  // 텍스트필드 편집 종료되면 백그라운드 색 변경
  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
  }
  
  // 엔터 누르면 일단 키보드 내림
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
