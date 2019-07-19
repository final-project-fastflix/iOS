//
//  DetailTableVC.swift
//  Fastflix
//
//  Created by Jeon-heaji on 16/07/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import SnapKit

final class DoNotUse: UITableViewController {
  
  private let label: UILabel = {
    let label = UILabel()
    label.text = "디테일 페이지"
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    return label
  }()
  
  private let button: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitleColor(.gray, for: .normal)
    button.addTarget(self, action: #selector(dismissBtnDidTap(_:)), for: .touchUpInside)
//    button.setImage(UIImage(named: "x"), for: .normal)
    button.setTitle("Get Token", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
    button.titleLabel?.textColor = .white
    button.layer.borderWidth = 1
    return button
  }()
  
  

  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.separatorStyle = .none
      tableView.backgroundColor = .clear
      tableView.addSubview(label)
      tableView.addSubview(button)
      
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
      
      label.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.centerY.equalToSuperview()
      }
      button.snp.makeConstraints {
          $0.top.equalTo(50)
          $0.centerX.equalToSuperview()
          $0.width.equalTo(330)
      }

    }
  
  @objc func dismissBtnDidTap(_ sneder: UIButton) {
    print("get token")
    APICenter.shared.login(id: "KHT@naver.com", pw: "1234") {
      switch $0 {
      case .success(_):
        print("Login Success!!!")
      case .failure(let err):
        print("fail to login, reason: ", err)
      }
      DispatchQueue.main.async {
        AppDelegate.instance.checkLoginState()
      }
    }
  }
  
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
