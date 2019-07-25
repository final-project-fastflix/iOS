//
//  DataForAPI.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/19.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation

enum RequestString: String {
  case loginURL = "http://52.78.134.79/accounts/login/"
  case movieURL = "http://52.78.134.79/movies/genre_select_before/"
}

// MARK: - Login
struct Login: Codable {
  let token: String
  let subUserList: [SubUserList]
  
  enum CodingKeys: String, CodingKey {
    case token
    case subUserList = "sub_user_list"
  }
}

// MARK: - SubUserList
struct SubUserList: Codable {
  let id: Int
  let name: String
  let kid: Bool
  let parentUser: Int
  
  enum CodingKeys: String, CodingKey {
    case id, name, kid
    case parentUser = "parent_user"
  }
}

// MARK: - RequestMovieElement
struct RequestMovieElement: Codable {
  let mainMovie: MainMovie
  let listOfGenre: [String: [ListOfGenre]]
  
  enum CodingKeys: String, CodingKey {
    case mainMovie = "메인 영화"
    case listOfGenre = "장르별 영화리스트"
  }
}

// MARK: - 메인영화
struct MainMovie: Codable {
  let id: Int
  let name: String
  let videoFile, sampleVideoFile, verticalSampleVideoFile: JSONNull?
  let productionDate, uploadedDate, synopsis, runningTime: String
  let viewCount: Int
  let logoImagePath: String
  let horizontalImagePath: String
  let verticalImage: String
  let circleImage: JSONNull?
  let bigImagePath: String
  let degree: Degree
  let directors, actors, feature, author: [Degree]
  let genre: [Degree]
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case videoFile = "video_file"
    case sampleVideoFile = "sample_video_file"
    case verticalSampleVideoFile = "vertical_sample_video_file"
    case productionDate = "production_date"
    case uploadedDate = "uploaded_date"
    case synopsis
    case runningTime = "running_time"
    case viewCount = "view_count"
    case logoImagePath = "logo_image_path"
    case horizontalImagePath = "horizontal_image_path"
    case verticalImage = "vertical_image"
    case circleImage = "circle_image"
    case bigImagePath = "big_image_path"
    case degree, directors, actors, feature, author, genre
  }
}

// MARK: - Degree
struct Degree: Codable {
  let id: Int
  let name: String
}

// MARK: - 장르별영화리스트
struct ListOfGenre: Codable {
  let id: Int
  let name: String
  let horizontalImagePath: String
  let verticalImage: String
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case horizontalImagePath = "horizontal_image_path"
    case verticalImage = "vertical_image"
  }
}

typealias RequestMovie = [RequestMovieElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
  
  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }
  
  public var hashValue: Int {
    return 0
  }
  
  public init() {}
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}
