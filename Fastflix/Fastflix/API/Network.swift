//
//  Network.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/10.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation


final class APICenter {
  static let shared = APICenter()
  
  private let loginUrl = URL(string: "http://54.180.191.152/accounts/login/")! 
  
  
  // MARK: - Login Method
  func login(id: String, pw: String, completion: @escaping (Result<Token, ErrorType>) -> ()) {
    let headers = [
      "content-type": "multipart/form-data; boundary=I don't want use it"
    ]
    
    let parameters = [
      [
        "name": "id",
        "value": id
      ],
      [
        "name": "pw",
        "value": pw
      ]
    ]
    
    let boundary = "I don't want use it"
    
    var body = ""
    let error: Error? = nil
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
    
    var request = URLRequest(url: loginUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = body.data(using: .utf8)
    
    
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, res, err) in
      guard err == nil else {
        completion(.failure(.networkError))
        return }
      
      guard let data = data else {
        completion(.failure(.NoData))
        return
      }
      
      guard let resultData = try? JSONDecoder().decode(Token.self, from: data) else {
        completion(.failure(.NoData))
        return
      }
      
      self.saveToken(token: resultData.token)
      completion(.success(resultData))
      
    }.resume()
  }
  
  
  // MARK: - save Token at UserDefaults with Key("token")
  private func saveToken(token: String) {
    let path = UserDefaults.standard
    
    path.set(token, forKey: "token")
    print("'Token' save complete ")
  }
  
}
