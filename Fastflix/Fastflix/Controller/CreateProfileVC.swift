//
//  ProfileVC.swift
//  Fastflix
//
//  Created by Jeon-heaji on 22/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class CreateProfileVC: UIViewController {
  
  lazy var createProfileView: CreateProfileView = {
    let view = CreateProfileView()
    view.delegate = self
    return view
  }()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    addSubViews()
    

  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupLayout()
  }
  
  private func addSubViews() {
    [createProfileView].forEach { view.addSubview($0) }
  }
  
  private func setupLayout() {
    
    createProfileView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
  }
  
}
extension CreateProfileVC: CreateProfileViewDelegate {
  func cancelBtndidTap(button: UIButton) {
    dismiss(animated: true)
    
  }
  
  func titleImageChange(button: UIButton) {
//    let iconVC = IconVC()
//    present(iconVC, animated: true)
    
  }
  
  
}
