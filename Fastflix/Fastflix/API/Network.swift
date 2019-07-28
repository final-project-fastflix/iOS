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
  let path = UserDefaults.standard
  
  // MARK: 유저디폴트에 저장된 토큰값 가져오기
  private func getToken() -> String {
    guard let token = path.string(forKey: "token") else {
      print("ERROR!!!, No Token")
      AppDelegate.instance.checkLoginState()
      return ""}
    return token
  }
  
  // MARK: (토큰값 및 서브유저아이디로)영화 데이터 받기
  func getMovieData(completion: @escaping (Result<RequestMovie>) -> ()) {
//    RequestMovie.self
    let token = getToken()
    let subUserID = getSubUserID()
    let headers = [
      "Authorization": "Token \(token)",
      "subuserid": "\(subUserID)"
    ]
    
    let request = Alamofire.request(RequestString.movieURL.rawValue, method: .get, headers: headers)
    
    request.response(queue: .main) {
      guard let data = $0.data else {
        completion(.failure(ErrorType.NoData))
        return }
      guard let resultData = try? JSONDecoder().decode(RequestMovie.self, from: data) else {
        completion(.failure(ErrorType.FailToParsing))
        print("data: ", data as? [String])
        return }
      completion(.success(resultData))
    }
    
//    request.responseJSON(queue: .global()) {
//      switch $0.result {
//      case .success(_):
//        guard let data = $0.data else { return }
//        guard let resultData = try? JSONDecoder().decode(RequestMovie.self, from: data) else { return completion(.failure(ErrorType.FailToParsing)) }
//        completion(.success(resultData))
//      case .failure(let err):
//        completion(.failure(ErrorType.networkError))
//      }
//    }
    
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
  func createSubUser(name: String, kid: String, completion: @escaping (Result<[SubUser]>) -> ()) {
    
    let token = getToken()
    
    let headers = [
      "Authorization": "Token \(token)"
    ]
    
    let parameters =
      [
        "name": name,
        "kid": kid
        ]
    
    Alamofire.upload(multipartFormData: {
      MultipartFormData in
      for (key, value) in parameters {
        MultipartFormData.append(value.data(using: .utf8)!, withName: key)
      }
      
    }, to: RequestString.createSubUserURL.rawValue, method: .post, headers: headers) {
      switch $0 {
      case .success(let upload, _, _):
        upload.responseJSON { (res) in
          
          guard let data = res.data else {
            completion(.failure(ErrorType.NoData))
            return }
          guard let origin = try? JSONDecoder().decode(SubUserList.self, from: data) else {
            completion(.failure(ErrorType.NoData))
            return }
          let subUserArr = origin.subUserList
          print("subUser: ", subUserArr)
          
          //서브유저 정보들 넘기기
          completion(.success(subUserArr))
        }
      case .failure(let err):
        print(err)
        completion(.failure(ErrorType.NoData))
        break
      }
    }
  }
  
  
  
  
  
  
}
