//
//  LaunchScreenVC.swift
//  Fastflix
//
//  Created by Jeon-heaji on 16/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
// LaunchScreen - rootViewController

final class LaunchScreenVC: UIViewController {
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "")
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    print("splash")
    
    // label의 알파를 천천히 바꾸는 거
//    UIView.animate(withDuration: 0.5) { [weak imageView = self.imageView] in
//      imageView?.alpha = 1
//    }
    
    // 3초 뒤에 뷰 컨트롤러를 띄우는거
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
      let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    

    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupSNP()
  }
  
  func setupSNP(){
    view.addSubview(imageView)
//    view.addSubview(label)
    
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
//    label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    
  }
}

