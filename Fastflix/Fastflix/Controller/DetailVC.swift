//
//  DetailVC.swift
//  Fastflix
//
//  Created by HongWeonpyo on 17/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

final class DetailVC: UITableViewController {
  
  private let movieTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "토이스토리"
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTableView()
//    makeConstraints()
    registerTableViewCell()
    
  }
  
  
  
  override func viewDidLayoutSubviews() {
    tableView.contentInset.top = -view.safeAreaInsets.top
  }
  
  
//  private func setupSNP() {
//
//    [dissmissButton].forEach { tableView.addSubview($0) }
//
//    //        tableView.snp.makeConstraints {
//    //            $0.top.leading.bottom.trailing.equalTo(view)
//    //        }
//
//    dissmissButton.snp.makeConstraints {
//      $0.width.height.equalTo(16)
//      $0.top.equalToSuperview().offset(5)
//      $0.trailing.equalToSuperview().offset(-5)
//    }
//  }
  
  private func registerTableViewCell() {
    tableView.register(DetailViewUpperCell.self, forCellReuseIdentifier: "DetailViewUpperCell")
    tableView.register(DetailViewBelowCell.self, forCellReuseIdentifier: "DetailViewBelowCell")
  }
  
  private func setTableView() {
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1)
    tableView.showsVerticalScrollIndicator = false
  }
  
  // 테이블뷰 데이터소스
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case 0 :
      let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewUpperCell", for: indexPath) as! DetailViewUpperCell
      cell.delegate = self
      return cell
      
    case 1 :
      let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewBelowCell", for: indexPath) as! DetailViewBelowCell
      cell.delegate = self
      return cell
      
    default:
      return UITableViewCell()
    }
  }
}

// (델리게이트) 플레이버튼 눌렀을때 플레이어 띄우기
extension DetailVC: PlayButtonDelegate {
  func didTapDismissBtn() {
    dismiss(animated: true)
  }
  
  func playButtonDidTap(sender: UIButton) {
    let detailVC = DetailVC()
    present(detailVC, animated: true)
  }
}

// (델리게이트) 디테일뷰 다시 띄우기
extension DetailVC: DetailViewCellDelegate {
  func detailViewDidSelectItemAt(indexPath: IndexPath) {
    let detailVC = DetailVC()
    present(detailVC, animated: true)
  }
}
