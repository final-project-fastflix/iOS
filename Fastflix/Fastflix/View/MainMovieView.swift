//
//  MainMovieView.swift
//  Fastflix
//
//  Created by Jeon-heaji on 23/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class MainMovieView: UIView {
  
  var receiveData: RequestMovie? = nil
  var receiveKeys: [String]? = nil
  
  private var originValue: CGFloat = 0
  
  private var compareArr: [CGFloat] = []
  
  private var originY: CGFloat {
    get {
      return floatingView.frame.origin.y
    }
    set {
      guard newValue >= -floatingView.frame.height || newValue <= 0 else { return }
      //      print("newValue", floatingView.frame)
      floatingView.frame.origin.y = newValue
    }
  }
  
  let floatingView: FloatingView = {
    let view = FloatingView()
    return view
  }()
  
  
  
  private let tableView = UITableView()
  
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    addSubViews()
    setupSNP()
    setupTableView()
    registerTableViewCell()
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = #colorLiteral(red: 0.07762928299, green: 0.07762928299, blue: 0.07762928299, alpha: 1)
    tableView.separatorStyle = .none
    tableView.allowsSelection = false

  }
  
  private func registerTableViewCell() {
    tableView.register(MainImageTableCell.self, forCellReuseIdentifier: MainImageTableCell.identifier)
    tableView.register(PreviewTableCell.self, forCellReuseIdentifier: PreviewTableCell.identifier)
    tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
    
  }
  
  private func addSubViews() {
    [tableView, floatingView]
      .forEach { self.addSubview($0) }
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
  

}

extension MainMovieView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (receiveKeys?.count ?? 8) + 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let mainData = receiveData?[0]
    var mainImgUrl: [String] = []
    
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: MainImageTableCell.identifier, for: indexPath) as! MainImageTableCell
      cell.selectionStyle = .none
      cell.configure(imageURLString: mainData?.mainMovie.bigImagePath, logoImageURLString: mainData?.mainMovie.logoImagePath)
      cell.movieDetailLabel.text = " 음악 ･ 마법을 걸어요 ･ 동화 ･ 사랑 ･ 걸파워 ･ 할리우드 영화 "
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: PreviewTableCell.identifier, for: indexPath) as! PreviewTableCell
      return cell
    default:
      
      let key = receiveKeys?[indexPath.row - 2] ?? ""
      print("key: ", key)
      
      if let data = mainData {
        for idx in data.listOfGenre[key]! {
          mainImgUrl.append(idx.verticalImage)
          print("string: ", idx.verticalImage)
          print("list: ", data.listOfGenre[key]?.count)
        }
      }
      print("count: ", mainImgUrl)
      let cell = MainCell()
      cell.configure(url: mainImgUrl, title: key)
      return cell
    }
  }
  
  
}

extension MainMovieView: UITableViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
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
    
    if offset <= -topPadding {
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
