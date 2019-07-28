//
//  Network.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/10.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation
import Alamofire


final class APICenter {
  static let shared = APICenter()
  
  // MARK: 유저디폴트 객체
  private let path = UserDefaults.standard
  
  private var token: String {
    return getToken()
  }
  
  private var subUserID: Int {
    return getSubUserID()
  }
  
  
  
  
  
  
  // MARK: - 필요한 헤더를 가져옴
  private func getHeader(needSubuser: Bool) -> ([String: String]) {
    
    let withSubuser = [
      "Authorization": "Token \(token)",
      "subuserid": "\(subUserID)"
    ]
    
    let withOutSubuser = [
      "Authorization": "Token \(token)"
    ]
    
    switch needSubuser {
    case true:
      return withSubuser
    case false:
      return withOutSubuser
    }
  }
  
  
  
  
  
  // MARK: - 프로필사진들 가져오기
  func changeProfileImage(completion: @escaping (Result<ProfileImage>) -> ()) {
    let header = getHeader(needSubuser: false)
    
    let req = Alamofire.request(RequestString.changeProfileListURL.rawValue, method: .get, headers: header)
    
    req.response(queue: .global()) { (res) in
      guard res.error == nil else {
        completion(.failure(ErrorType.networkError))
        return }
      
      guard let data = res.data else {
        completion(.failure(ErrorType.NoData))
        return
      }
      
      guard let result = try? JSONDecoder().decode(ProfileImage.self, from: data) else {
        completion(.failure(ErrorType.FailToParsing))
        return
      }
      
      completion(.success(result))
    }
  }
  
  // MARK: 유저디폴트에 저장된 토큰값 가져오기
  private func getToken() -> String {
    guard let token = path.string(forKey: "token") else {
      print("ERROR!!!, No Token")
      AppDelegate.instance.checkLoginState()
      return ""}
    return token
  }
  
  func getMainImgCellData(completion: @escaping (Result<MainImgCellData>) -> ()) {
    let header = getHeader(needSubuser: true)
    
    let req = Alamofire.request(RequestString.getMainImgURL.rawValue, method: .get, headers: header)
    
    req.response(queue: .global()) { (res) in
      guard res.error == nil else {
        completion(.failure(ErrorType.networkError))
        return
      }
      
      guard let data = res.data else {
        completion(.failure(ErrorType.NoData))
        return
      }
      
      guard let result = try? JSONDecoder().decode(MainImgCellData.self, from: data) else {
        completion(.failure(ErrorType.FailToParsing))
        return
      }
      
      completion(.success(result))
    }
  }
  
  // MARK: (토큰값 및 서브유저아이디로)영화 데이터 받기
  func getMovieData(completion: @escaping (Result<RequestMovie>) -> ()) {
    //    RequestMovie.self
    let headers = getHeader(needSubuser: true)
    
    let request = Alamofire.request(RequestString.movieURL.rawValue, method: .get, headers: headers)
    
    request.response(queue: .main) {
      guard let data = $0.data else {
        completion(.failure(ErrorType.NoData))
        return }
      guard let resultData = try? JSONDecoder().decode(RequestMovie.self, from: data) else {
        completion(.failure(ErrorType.FailToParsing))
//        print("data: ", data as? [String])
        return }
      completion(.success(resultData))
    }
  }
  
  
  // MARK: 로그인 메서드 -> 토큰값 저장 및 컴플리션에 서브유저 배열 넘기기
  func login(id: String, pw: String, completion: @escaping (Result<[SubUser]>) -> ()) {
    
    let parameters =
      [
        "id": id,
        "pw": pw
    ]
    
    Alamofire.upload(multipartFormData: {
      MultipartFormData in
      for (key, value) in parameters {
        MultipartFormData.append(value.data(using: .utf8)!, withName: key)
      }
      
    }, to: RequestString.loginURL.rawValue, method: .post) {
      switch $0 {
      case .success(let upload, _, _):
        upload.responseJSON { (res) in
          //          print("run", res.data as? [String: String])
          guard let data = res.data else {
            completion(.failure(ErrorType.NoData))
            return }
          guard let origin = try? JSONDecoder().decode(Login.self, from: data) else {
            completion(.failure(ErrorType.NoData))
            return }
          let token = origin.token
          let subUserArr = origin.subUserList
          print("subUser: ", subUserArr)
          
          // 토큰값 유저디폴트에 저장하기
          self.saveToken(token: token)
          
          completion(.success(subUserArr))
        }
      case .failure(let err):
        print(err)
        completion(.failure(ErrorType.NoData))
        break
      }
    }
  }
  
  // MARK: 유저디폴트에 키값"token"로 토큰값 저장하기
  private func saveToken(token: String) {
    path.set(token, forKey: "token")
    print("'Token' save complete ")
  }
  
  
  // MARK: 서브 유저 관련 메서드
  // MARK: 유저디폴트에 Int값으로된 서브유저 아이디 가져오기
  func getSubUserID() -> Int {
    print("subUserID: ", path.integer(forKey: "subUserID"))
    return path.integer(forKey: "subUserID")
  }
  
  // MARK: 유저디폴트에 Int값으로 서브유저 아이디 저장하기
  func saveSubUserID(id: Int) {
    path.set(id, forKey: "subUserID")
    print("'subUserID' save complete ")
  }
  
  // MARK: 유저디폴트에 현재 저장된 서브유저 아이디 지우기
  func deleteCurrentSubUserID() {
    path.removeObject(forKey: "subUserID")
    print("'subUserID' is deleted")
  }
  
  
  // MARK: 서브유저 생성
  func createSubUser(name: String, kid: Bool, completion: @escaping (Result<[SubUser]>) -> ()) {
    
    let headers = getHeader(needSubuser: false)
    
    let parameters: [String : Any] =
      [
        "name": name,
        "kid": NSNumber(value: kid)
        ]
    
    Alamofire.request(RequestString.createSubUserURL.rawValue, method: .post, parameters: parameters, headers: headers)
      .validate()
      .responseJSON { response in
          guard response.result.isSuccess,
            let _ = response.result.value else {
              print("Error while fetching tags: \(String(describing: response.result.error))")
              completion(.failure(ErrorType.NoData))
              return
          }
          guard let data = response.data else {
            completion(.failure(ErrorType.NoData))
            return
          }
          guard let origin = try? JSONDecoder().decode(SubUserList.self, from:data) else {
            completion(.failure(ErrorType.NoData))
            return
          }
          let subUserArr = origin.subUserList
          print("유저생성 subUser: ", subUserArr)
        
          //서브유저 정보들 넘기기
          completion(.success(subUserArr))
        
        
        
        
//      switch response.result {
//      case .success(let response):
//        print("========성공 성공 성공=========")
//        guard let data = response.data else {
//            completion(.failure(ErrorType.NoData))
//            return }
//        guard let origin = try? JSONDecoder().decode(SubUserList.self, from: data) else {
//            completion(.failure(ErrorType.NoData))
//            return }
//        let subUserArr = origin.subUserList
//        print("유저생성 subUser: ", subUserArr)
//
//        //서브유저 정보들 넘기기
//        completion(.success(subUserArr))
//
//      case .failure(let err):
//        print(err)
//        completion(.failure(ErrorType.NoData))
//        break
//        }
    }
    
//    switch $0 {
//    case .success(let upload, _, _):
//      upload.responseJSON { (res) in
//        //          print("run", res.data as? [String: String])
//        guard let data = res.data else {
//          completion(.failure(ErrorType.NoData))
//          return }
//        guard let origin = try? JSONDecoder().decode(Login.self, from: data) else {
//          completion(.failure(ErrorType.NoData))
//          return }
//        let token = origin.token
//        let subUserArr = origin.subUserList
//        print("subUser: ", subUserArr)
//
//        // 토큰값 유저디폴트에 저장하기
//        self.saveToken(token: token)
//
//        completion(.success(subUserArr))
//      }
//    case .failure(let err):
//      print(err)
//      completion(.failure(ErrorType.NoData))
//      break
//    }
    
  }
  
}
