//
//  MainHomeVC.swift
//  Fastflix
//
//  Created by Jeon-heaji on 21/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit
import AVKit

class MainHomeVC: UIViewController {
  
  var originValue: CGFloat = 0
  
  var compareArr: [CGFloat] = []
  
  var originY: CGFloat {
    get {
      return floatingView.frame.origin.y
    }
    set {
      guard newValue >= -94 || newValue <= 0 else { return }
//      print("newValue", floatingView.frame)
      floatingView.frame.origin.y = newValue
    }
  }
  
  private var streamingCellFocus = false {
    willSet(newValue) {
      newValue ? streamingCell.playVideo() : streamingCell.pauseVideo()
    }
  }
  
  private lazy var tableView: UITableView = {
    let tbl = UITableView()
    tbl.dataSource = self
    tbl.delegate = self
    tbl.backgroundColor = #colorLiteral(red: 0.07762928299, green: 0.07762928299, blue: 0.07762928299, alpha: 1)
    tbl.separatorStyle = .none
    tbl.allowsSelection = false
    tbl.showsVerticalScrollIndicator = false
    return tbl
  }()
  
  private let streamingCell: StreamingCell = {
    let cell = StreamingCell()
    cell.configure(url: streamingUrl)
    return cell
  }()
  
  private lazy var floatingView: FloatingView = {
    let view = FloatingView()
    view.delegate = self
    return view
  }()
  
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubViews()
    
    registerTableViewCell()
//    view.clipsToBounds = true
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupSNP()
  }
  
  
  
  private func addSubViews() {
    [tableView, floatingView].forEach { view.addSubview($0) }
  }
  
  private func setupSNP() {
    tableView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    floatingView.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview()
      $0.height.equalTo(50 + topPadding)
    }
  }
  
  private func registerTableViewCell() {
    
    tableView.register(MainImageTableCell.self, forCellReuseIdentifier: MainImageTableCell.identifier)
    tableView.register(PreviewTableCell.self, forCellReuseIdentifier: PreviewTableCell.identifier)
    tableView.register(OriginalTableCell.self, forCellReuseIdentifier: OriginalTableCell.identifier)
    tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
    
  }
  
}

extension MainHomeVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: MainImageTableCell.identifier, for: indexPath) as! MainImageTableCell
      cell.selectionStyle = .none
      cell.movieDetailLabel.text = " 슈퍼히어로 ･ 사이보그 & 로봇 ･ SF ･ 액션 ･ 할리우드 영화 "
      cell.configure(imageURLString: ImagesData.shared.imagesUrl[2], logoImageURLString: ImagesData.shared.imagesUrl[4])
      return cell
      
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: PreviewTableCell.identifier, for: indexPath) as! PreviewTableCell
      cell.delegate = self
      cell.selectionStyle = .none
      return cell
      
    case 5:
      let cell = streamingCell
      return cell
      
    case 7:
      let cell = tableView.dequeueReusableCell(withIdentifier: OriginalTableCell.identifier, for: indexPath) as! OriginalTableCell
      cell.selectionStyle = .none
      cell.delegate = self
      return cell
      
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as! MainCell
      cell.configure(url: imageUrls, title: "\(indexPath)")
      return cell
    }
  }
  
  
  
}


extension MainHomeVC: PreviewTableCellDelegate {
  func didSelectItemAt(indexPath: IndexPath) {
    let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/test-64199.appspot.com/o/%E1%84%82%E1%85%A6%E1%86%BA%E1%84%91%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8%E1%84%89%E1%85%B3%E1%84%86%E1%85%B5%E1%84%85%E1%85%B5%E1%84%87%E1%85%A9%E1%84%80%E1%85%B5%E1%84%80%E1%85%A1%E1%84%8B%E1%85%A9%E1%84%80%E1%85%A2%E1%86%AF2.mp4?alt=media&token=96a3f3ef-3ff9-4f05-9675-2f13232a72cf")!
    
    let playerVC = AVPlayerViewController()
    let player = AVPlayer(url: url)
    playerVC.player = player
    
    present(playerVC, animated: true) {
      playerVC.player?.play()
    }
  }
  
}


extension MainHomeVC: OriginalTableCellDelegate {
  func originalDidSelectItemAt(indexPath: IndexPath) {
    //    let detailVC = DetailTableVC()
    let detailVC = DetailVC()
    print("present DetailVC")
    present(detailVC, animated: true)
  }
  
}

extension MainHomeVC: UITableViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let state = tableView.cellForRow(at: IndexPath(row: 5, section: 0))?.alpha
    
    streamingCellFocus = (state == nil) ? false : true
    
    //    print(scrollView.contentOffset.y)
    let offset = scrollView.contentOffset.y
    
    let transition = scrollView.panGestureRecognizer.translation(in: scrollView).y.rounded()
    
    let fixValue = floatingView.frame.size.height
    
    var compareValue: CGFloat = 0
    
    var floatValue: CGFloat {
      get {
        return originValue
      }
      set {
        if newValue > -fixValue && newValue < 0 {
          originValue = newValue
        } else if newValue < -fixValue {
          originValue = -fixValue
        } else {
          return
        }
        
      }
    }
    
    
    if compareArr.count > 1 {
      compareArr.remove(at: 0)
    }
    compareArr.append(offset)
    
    if offset <= -44 {
      floatingView.frame.origin.y = 0
      return
    }
    
    if compareArr.count == 2 {
      if compareArr[0] > compareArr[1] {
        // show
        let addtionalValue = compareArr[1] - compareArr[0]
        floatValue += -addtionalValue
        originY = floatValue
        return
      } else if compareArr[0] < compareArr[1] {
        // hide
        let addtionalValue = compareArr[1] - compareArr[0]
        floatValue += -addtionalValue
        originY = floatValue
        return
      } else {
        return
      }
    }
    
    
    
    
    //    print("transition: ", transition)
    //    print("originValue: ", originValue)
    // hide
    
    
    //    if transition < 0, transition >= -940 {
    //      guard originY >= -94 || originY <= 0 else { return }
    //      floatValue += transition/10
    //      originY = floatValue
    //    }else if transition > 0, transition <= 94 {
    //      // show
    //
    //      guard originY >= -940 || originY <= 0 else { return }
    //      floatValue += transition/10
    //      originY = floatValue
    //    }
    //
    //
    //
    
    
    
    //    if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
    //
    //      UIView.animate(withDuration: 1.5) {
    //        self.navigationController?.hidesBarsOnSwipe = true
    //        UIView.animate(withDuration: 1.7, animations: {
    //          self.navigationController?.navigationBar.alpha = 0
    //        })
    //
    ////        print("내려감")
    //      }
    //
    //    } else {
    //      UIView.animate(withDuration: 1.5) {
    //        self.navigationController?.hidesBarsOnSwipe = false
    //        self.navigationController?.setNavigationBarHidden(false, animated: false)
    //        UIView.animate(withDuration: 1.7, animations: {
    //          self.navigationController?.navigationBar.alpha = 1
    //
    //        })
    ////        print("올라감??")
    //      }
    //
    //    }
    
    
  }
}


extension MainHomeVC: FloatingViewDelegate {
  func didTapHome() {
    AppDelegate.instance.checkLoginState()
  }
  
  func didTapMovie() {
    streamingCell.pauseVideo()
    
    APICenter.shared.getMovieData {
      switch $0 {
      case .success(let value):
        let mainMovieVC = MainMovieVC()
        mainMovieVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "tabBarhome2"), tag: 0)
        mainMovieVC.receiveData = value
        self.tabBarController?.viewControllers?[0] = mainMovieVC
      case .failure(let err):
        print("ErrorType: ", err)
      }
    }
    
    
    
  }
  
  func didTapPoke() {
    streamingCell.pauseVideo()
    let mainPokeVC = MainPokeVC()
    mainPokeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "tabBarhome2"), tag: 0)
    tabBarController?.viewControllers?[0] = mainPokeVC
  }
}
