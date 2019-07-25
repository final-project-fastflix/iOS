//
//  AfterLoginVC.swift
//  TestRequest
//
//  Created by hyeoktae kwon on 2019/07/20.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class AfterLoginVC: UIViewController {
  
  let logoutBtn: UIButton = {
    let btn = UIButton()
    btn.setTitle("LOGOUT", for: .normal)
    btn.setTitleColor(.black, for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    btn.layer.borderWidth = 1
    btn.layer.borderColor = UIColor.init(named: "black")?.cgColor
    btn.addTarget(self, action: #selector(didTabBtn(_:)), for: .touchUpInside)
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()
  
  let getMovies: UIButton = {
    let btn = UIButton()
    btn.setTitle("Get Movies", for: .normal)
    btn.setTitleColor(.black, for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    btn.layer.borderWidth = 1
    btn.layer.borderColor = UIColor.init(named: "black")?.cgColor
    btn.addTarget(self, action: #selector(didTabGetMovies(_:)), for: .touchUpInside)
    btn.translatesAutoresizingMaskIntoConstraints = false
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAutoLayout()
    var number = 1234
    test(&number)
    print(number)
  }
  
  @objc func didTabBtn(_ sender: UIButton) {
    UserDefaults.standard.removeObject(forKey: "token")
    let checkLoginState = AppDelegate.instance
        checkLoginState.checkLogtinState()
  }
  
  @objc func didTabGetMovies(_ sender: UIButton) {
    APICenter.shared.requestMovie()
  }
  
  private func setupAutoLayout() {
    view.addSubview(logoutBtn)
    view.addSubview(getMovies)
    
    logoutBtn.heightAnchor.constraint(equalToConstant: 400).isActive = true
    logoutBtn.widthAnchor.constraint(equalToConstant: 400).isActive = true
    logoutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    logoutBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    
    getMovies.heightAnchor.constraint(equalToConstant: 100).isActive = true
    getMovies.widthAnchor.constraint(equalToConstant: 400).isActive = true
    getMovies.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    getMovies.topAnchor.constraint(equalTo: logoutBtn.bottomAnchor, constant: 20).isActive = true
  }
  
  
  func test( _ num: inout Int) {
    var resultArr: [Int] = []
    while num > 0 {
      resultArr.insert(num%10, at: 0)
      num = num/10
    }
    print(resultArr)
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
