//
//  DataOfAllen.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/10.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation

final class SubUserSingleton {
  
  static let shared = SubUserSingleton()
  
  var subUserList: [SubUser]?
  
  init() {

  }
  
  func checkSubUserList() -> [SubUser]? {
    return subUserList
  }
  
  func addSubUser(newUser: SubUser) {
    subUserList?.append(newUser)
  }
  
  func deleteSubUser(disappearingUser: SubUser) {
//    let user = subUsers.filter { $0.id == disappearingUser.id }.first!
//    if let index = subUsers.firstIndex(of: user) {
//      subUsers.remove(at: index)
//    }
    
  }
  
  func changeSubUserInfo(user: SubUser) {
    
  }
  
}
