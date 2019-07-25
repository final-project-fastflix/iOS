//
//  MainMovieVC.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/23.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
import Alamofire

class MainMovieVC: UIViewController {
  
  var receiveData: RequestMovie? = nil {
    willSet(new) {
      receiveKeys = new?[0].listOfGenre.keys.sorted()
//      loadView()
    }
  }
  lazy var receiveKeys: [String]? = nil
  
  override func loadView() {
    let mainMovieView = MainMovieView()
    mainMovieView.receiveKeys = receiveKeys
    mainMovieView.receiveData = receiveData
    mainMovieView.floatingView.delegate = self
    self.view = mainMovieView
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
}

extension MainMovieVC: FloatingViewDelegate {
  func didTapHome() {
    AppDelegate.instance.checkLoginState()
  }
  
  func didTapMovie() {
    let mainMovieVC = self
    mainMovieVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "tabBarhome2"), tag: 0)
    tabBarController?.viewControllers?[0] = mainMovieVC
  }
  
  func didTapPoke() {
    let mainPokeVC = MainPokeVC()
    mainPokeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "tabBarhome2"), tag: 0)
    tabBarController?.viewControllers?[0] = mainPokeVC
  }
  
  
}
