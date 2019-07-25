//
//  MainTabBarController.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/16.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit

final class MainTabBarController: UITabBarController {
  
  // MARK: - Properties
  private let mainHomeVC = MainHomeVC()
  private let downloadVC = DownloadVC()
  private let seeMoreVC = SeeMoreVC()
  private let searchVC = SearchVC()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }
  
  private func setupTabBar() {
    installTabBarItems()
    
    tabBar.tintColor = .white
    tabBar.backgroundImage = UIImage(named: "black")
    
    self.viewControllers = [mainHomeVC, searchVC, downloadVC, seeMoreVC]
  }
  
  private func installTabBarItems() {
    let homeVCItem = UITabBarItem(title: "홈", image: UIImage(named: "tabBarhome2"), tag: 0)
    let searchVCItem = UITabBarItem(title: "검색", image: UIImage(named: "tabBarSearch1"), tag: 1)
    let downloadVCItem = UITabBarItem(title: "저장한 콘텐츠 목록", image: UIImage(named: "tabBarDownLoad1"), tag: 2)
    let seeMoreVCItem = UITabBarItem(title: "더 보기", image: UIImage(named: "tabBarSeeMore1"), tag: 3)
    
    downloadVCItem.badgeValue = "☁︎"
    downloadVCItem.badgeColor = .blue
    
    mainHomeVC.tabBarItem = homeVCItem
    searchVC.tabBarItem = searchVCItem
    downloadVC.tabBarItem = downloadVCItem
    seeMoreVC.tabBarItem = seeMoreVCItem
  }
  
  // what is it?
  func playBounceAnimation(_ icon : UIImageView) {
    
    let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
    bounceAnimation.duration = 2
    bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
    //      bounceAnimation.calculationMode = kCAAnimationCubic
    
    icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
    
  }
  
}
