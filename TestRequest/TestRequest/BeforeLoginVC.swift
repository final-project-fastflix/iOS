//
//  BeforeLoginVC.swift
//  TestRequest
//
//  Created by hyeoktae kwon on 2019/07/20.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class BeforeLoginVC: UIViewController {
  
  let loginBtn: UIButton = {
    let btn = UIButton()
    btn.setTitle("GET TOKEN", for: .normal)
    btn.setTitleColor(.black, for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    btn.layer.borderWidth = 1
    btn.layer.borderColor = UIColor.init(named: "black")?.cgColor
    btn.addTarget(self, action: #selector(didTabBtn(_:)), for: .touchUpInside)
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAutoLayout()
    APICenter.shared.getMainCellData()
  }
  
  @objc func didTabBtn(_ sender: UIButton) {
    let checkLoginState = AppDelegate.instance
    APICenter.shared.loginAlamofire { state in
      DispatchQueue.main.async {
        state ? checkLoginState.checkLogtinState() : print("fail to login")
      }
    }
  }
  
  private func setupAutoLayout() {
    view.addSubview(loginBtn)
    
    loginBtn.heightAnchor.constraint(equalToConstant: 400).isActive = true
    loginBtn.widthAnchor.constraint(equalToConstant: 400).isActive = true
    loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
