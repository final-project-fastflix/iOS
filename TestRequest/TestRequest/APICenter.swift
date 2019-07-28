//
//  Network.swift
//  TestRequest
//
//  Created by hyeoktae kwon on 2019/07/14.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation
import Alamofire

class APICenter {
  static let shared = APICenter()
  
  private let movieURL = "http://52.78.134.79/movies/genre_select_before/"
  private let loginURL = "http://52.78.134.79/accounts/login/"
  
  
  private func getToken() -> String {
    guard let token = UserDefaults.standard.string(forKey: "token") else {
      print("ERROR!!!, No TOKEN")
      AppDelegate.instance.checkLogtinState()
      return ""}
    return token
  }
  
  func requestMovie() {
    let token = getToken()
    
    let header = [
      "Authorization": "Token \(token)"
    ]
    
    let request = Alamofire.request(movieURL, method: .get, headers: header)
    
    request.response(queue: .main) { (response) in
      guard let data = response.data else { return }
      do {
        let result = try Alamofire.JSONDecoder().decode(RequestMovie.self, from: data)
        print("result: ", result[0].listOfGenre.keys)
      } catch(let err) {
        print("error: ", err.localizedDescription)
      }
      
    }
    
  }
  
  
  func loginAlamofire(compltion: @escaping (Bool)->() ) {
    
    let parameters =
      [
        "id": "KHT@naver.com",
        "pw": "1234"
      ]
    
    
    Alamofire.upload(multipartFormData: { MultipartFormData in
        for (key, value) in parameters {
          MultipartFormData.append(value.data(using: .utf8)!, withName: key)
        }
      
    }, to: loginURL, method: .post) { (result) in
      switch result {
      case .success(let upload, _, _):
        upload.responseJSON { (res) in
          guard let origin = res.result.value as? [String: String] else { return }
          let value = origin["token"]
          print("token: ", value)
          UserDefaults.standard.setValue(value, forKey: "token")
          compltion(true)
        }
      case .failure(let err):
        print(err)
        compltion(false)
        break
      }
    }
    
    
  }
  
  
  func postman() {
    
    let headers = [
      "content-type": "multipart/form-data; boundary=I don't want use it"
    ]
    
    let parameters = [
      [
        "name": "id",
        "value": "KHT@naver.com"
      ],
      [
        "name": "pw",
        "value": "1234"
      ]
    ]
    
    let boundary = "I don't want use it"
    
    var body = ""
    let error: NSError? = nil
    for param in parameters {
      let paramName = param["name"]!
      body += "--\(boundary)\r\n"
      body += "Content-Disposition:form-data; name=\"\(paramName)\""
      if let filename = param["fileName"] {
        let contentType = param["content-type"]!
        let fileContent = try? String(contentsOfFile: filename, encoding: String.Encoding.utf8)
        if (error != nil) {
          print(error!.localizedDescription)
        }
        body += "; filename=\"\(filename)\"\r\n"
        body += "Content-Type: \(contentType)\r\n\r\n"
        body += fileContent!
      } else if let paramValue = param["value"] {
        body += "\r\n\r\n\(paramValue)"
      }
    }
    
    let request = NSMutableURLRequest(url: NSURL(string: "http://54.180.191.152/accounts/login/")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = body.data(using: .utf8)
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print(error!.localizedDescription)
      } else {
        let httpResponse = response as? HTTPURLResponse
        print(httpResponse!.statusCode)
        let result = try? JSONSerialization.jsonObject(with: data!) as? [String: String]
        print(result?.values)
      }
    })
    dataTask.resume()
  }
  
  
  
  
  func testAccount() {
    let url = URL(string: movieURL)!
    var request = URLRequest(url: url)
    
    let header = ["Authorization": "Token 82490a0c0d66c206dd3825ae882a4f7646cd77ba"]
    
    request.allHTTPHeaderFields = header
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, res, err) in
      guard let response = res as? HTTPURLResponse else { return }
      print("response code: ", response)
      guard let data = data else { return }
      let result = try? JSONDecoder().decode(RequestMovie.self, from: data)
      print(result)
      }.resume()
  }
  
  func getMainCellData() {
    let url = "http://52.78.134.79/movies/"
    
    let header = [
      "Authorization": "Token 58ed2cf80bc30631a6315b8c557edb7395f03207",
      "subuserid": "11"
    ]
    
    let req = Alamofire.request(url, method: .get, headers: header)
    
    req.response(queue: .global()) { (res) in
      guard let data = res.data else { return }
      guard let result = try? JSONDecoder().decode(Test.self, from: data) else {
        print("FailToParsing")
        return }
      
      print(result)
    }
  }
  
  
  func changeProfile() {
    let url = "http://52.78.134.79/accounts/change_profile/"
    
    let header = [
      "Authorization": "Token 58ed2cf80bc30631a6315b8c557edb7395f03207"
    ]
    
    let profileRequest = Alamofire.request(url, method: .get, headers: header)
    
    profileRequest.response(queue: .global()) { (res) in
      guard let data = res.data else { return }
      let result = try? JSONDecoder().decode(ProfileImage.self, from: data)
      print("result: ", result)
    }
  }
  
  
//  func request() {
//
//    let url = URL(string: "http://52.78.134.79/movies/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
//    print(url)
//    URLSession.shared.dataTask(with: url) { (data, res, err) in
//
//      guard err == nil, let data = data else { return }
//      let result = try? JSONDecoder().decode(Movie.self, from: data)
//      print("all: ", result)
//      }.resume()
//
//    let url2 = URL(string: "http://52.78.134.79/movies/genre/액션/list/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
//    print(url2)
//    URLSession.shared.dataTask(with: url2) { (data, res, err) in
//
//      guard err == nil, let data = data else { return }
//      let result = try? JSONDecoder().decode(Movie.self, from: data)
//      print("not all: ", result?.count)
//      }.resume()
//  }
}
