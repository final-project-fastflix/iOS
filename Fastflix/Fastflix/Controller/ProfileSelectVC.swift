//
//  ProfileSelectVC.swift
//  Fastflix
//
//  Created by HongWeonpyo on 24/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class ProfileSelectVC: UIViewController {

  // 네이게이션뷰
  lazy var navigationView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.addSubview(profileManageLabel)
    view.addSubview(logoView)
    view.addSubview(changeButton)
    view.addSubview(finishButton)
    return view
  }()
  
  // 로고
  let logoView: UIImageView = {
    let image = UIImage(named: "fastflix")
    let view = UIImageView()
    view.image = image
    view.contentMode = .scaleToFill
    return view
  }()
  
  // 프로필관리 레이블(edit할때 나타나는 label)
  let profileManageLabel: UILabel = {
    let label = UILabel()
    label.text = "프로필 관리"
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 17)
    label.isHidden = true
    return label
  }()
  
  // 변경 버튼
  lazy var changeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("변경", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(changeButtonTapped(_:)), for: .touchUpInside)
    return button
  }()
  
  // 완료 버튼
  lazy var finishButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("완료", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(finishButtonTapped(_:)), for: .touchUpInside)
    button.isHidden = true
    return button
  }()
  
  // 안내문구
  let introlabel: UILabel = {
    let label = UILabel()
    label.text = "Netflix를 시청할 프로필을 선택하세요."
    label.font = UIFont.systemFont(ofSize: 20, weight: .light)
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  var profileImageView1 = UserView()
  var profileImageView2 = UserView()
  var profileImageView3 = UserView()
  var profileImageView4 = UserView()
  var profileImageView5 = UserView()
  var addProfileView = AddProfileView()
  
  var numberOfUsers: Int?
  var subUserList: [SubUserList]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("numberOfUsers:", numberOfUsers)
    configure()
    addSubViews()
    navigationBarSetting()
    setUserViews()
    setFuntions()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupSNP()
    setupProfileLayout()
  }
  
  private func configure() {
    view.backgroundColor = .black
  }
  
  private func addSubViews() {
    [navigationView, introlabel, profileImageView1, profileImageView2, profileImageView3, profileImageView4, profileImageView5, addProfileView].forEach { view.addSubview($0) }
  }
  
  private func setupSNP() {
    
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
    
    profileManageLabel.snp.makeConstraints {
      $0.bottom.equalTo(navigationView.snp.bottom).offset(8)
      $0.centerX.equalTo(navigationView.snp.centerX)
      $0.width.equalToSuperview().multipliedBy(0.25)
      $0.height.equalTo(logoView.snp.width).multipliedBy(0.70)
    }
    
    changeButton.snp.makeConstraints {
      $0.centerY.equalTo(logoView.snp.centerY)
      $0.trailing.equalTo(view.snp.trailing).offset(-15)
    }
    
    finishButton.snp.makeConstraints {
      $0.centerY.equalTo(logoView.snp.centerY)
      $0.leading.equalTo(view.snp.leading).offset(15)
    }
    
    introlabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(navigationView.snp.bottom).offset(35)
    }
    
    profileImageView1.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
      $0.centerX.equalToSuperview().offset(-70)
      $0.top.equalTo(introlabel.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
    }
    
    profileImageView2.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
      $0.centerX.equalToSuperview().offset(70)
      $0.top.equalTo(introlabel.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
    }
    
    profileImageView3.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
      $0.centerX.equalToSuperview().offset(-70)
      $0.top.equalTo(profileImageView1.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
    }
    
    profileImageView4.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
      $0.centerX.equalToSuperview().offset(70)
      $0.top.equalTo(profileImageView1.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
    }
    
    profileImageView5.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileImageView3.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
    }
  }
  
  func setupProfileLayout() {
    
    switch numberOfUsers {
    case 1:
      profileImageView2.isHidden = true
      profileImageView3.isHidden = true
      profileImageView4.isHidden = true
      profileImageView5.isHidden = true
      addProfileView.snp.makeConstraints {
        $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
        $0.centerX.equalToSuperview().offset(70)
        $0.top.equalTo(introlabel.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
      }
    case 2:
      profileImageView3.isHidden = true
      profileImageView4.isHidden = true
      profileImageView5.isHidden = true
      addProfileView.snp.makeConstraints {
        $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
        $0.centerX.equalToSuperview()
        $0.top.equalTo(profileImageView1.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
      }
    case 3:
      profileImageView4.isHidden = true
      profileImageView5.isHidden = true
      addProfileView.snp.makeConstraints {
        $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
        $0.centerX.equalToSuperview().offset(70)
        $0.top.equalTo(profileImageView1.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
      }
    case 4:
      profileImageView5.isHidden = true
      addProfileView.snp.makeConstraints {
        $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
        $0.centerX.equalToSuperview()
        $0.top.equalTo(profileImageView3.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
      }
    case 5:
      addProfileView.snp.makeConstraints {
        $0.width.equalTo(UIScreen.main.bounds.width * 0.32)
        $0.centerX.equalToSuperview()
        $0.top.equalTo(profileImageView3.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
      }
      addProfileView.isHidden = true
    default:
      addProfileView.isHidden = true
    }
  }
  
  func setUserViews() {
  
    profileImageView1.profileUserName = subUserList?[0].name ?? "테스트"
    profileImageView2.profileUserName = subUserList?[1].name ?? "테스트"
    profileImageView3.profileUserName = subUserList?[2].name ?? "테스트"
    profileImageView4.profileUserName = subUserList?[3].name ?? "테스트"
    profileImageView5.profileUserName = subUserList?[4].name ?? "테스트"
    
    profileImageView1.tag = subUserList?[0].id ?? 95
    profileImageView2.tag = subUserList?[1].id ?? 96
    profileImageView3.tag = subUserList?[2].id ?? 97
    profileImageView4.tag = subUserList?[3].id ?? 98
    profileImageView5.tag = subUserList?[3].id ?? 99
  
  }
  
  
  private func navigationBarSetting() {
    let navCon = navigationController!
    navCon.isNavigationBarHidden = true
  }
  
  @objc private func changeButtonTapped(_ sender: UIButton) {
    [profileManageLabel, finishButton].forEach { $0.isHidden = false }
    [changeButton, logoView, introlabel ].forEach { $0.isHidden = true }
    [profileImageView1, profileImageView2, profileImageView3, profileImageView4, profileImageView5].forEach { $0.isEditing = true }
  }
  
  @objc private func finishButtonTapped(_ sender: UIButton) {
    [profileManageLabel, finishButton].forEach { $0.isHidden = true }
    [changeButton, logoView, introlabel ].forEach { $0.isHidden = false }
    [profileImageView1, profileImageView2, profileImageView3, profileImageView4, profileImageView5].forEach { $0.isEditing = false }
  }
  
}

extension ProfileSelectVC: UserViewDelegate {
  private func setFuntions() {
    [profileImageView1, profileImageView2, profileImageView3, profileImageView4, profileImageView5].forEach { $0.delegate = self }
  }
  
  func didSelectUser(tag: Int) {    
    
//    APICenter.shared.saveSubUserID(id: tag)
//    DispatchQueue.main.async {
//      AppDelegate.instance.checkLoginState()
//    }
    
    let tabBar = MainTabBarController()
    present(tabBar, animated: false)
    
  }
}
