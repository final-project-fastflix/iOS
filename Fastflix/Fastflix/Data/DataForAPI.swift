//
//  DataForAPI.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/19.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation

// MARK: - URLString
enum RequestString: String {
  case loginURL = "http://52.78.134.79/accounts/login/"
  case movieURL = "http://52.78.134.79/movies/genre_select_before/"
  case requestSubUserListURL = "http://52.78.134.79/accounts/sub_user_list/"
  case createSubUserURL = "http://52.78.134.79/accounts/create_sub_user/"
  case changeProfileListURL = "http://52.78.134.79/accounts/change_profile/"
  case getMainImgURL = "http://52.78.134.79/movies/"
}

// MARK: - ProfileImageElement
struct ProfileImageElement: Codable {
  let name: String
  let imagePath: String
  
  enum CodingKeys: String, CodingKey {
    case name
    case imagePath = "image_path"
  }
}

typealias ProfileImage = [String: [ProfileImageElement]]




// MARK: - Login
struct Login: Codable {
  let token: String
  let subUserList: [SubUserList]
  
  enum CodingKeys: String, CodingKey {
    case token
    case subUserList = "sub_user_list"
  }
}

struct SubUser: Codable {
  let subUserList: [SubUserList]
  
  enum CodingKeys: String, CodingKey {
    case subUserList = "sub_user_list"
  }
}

// MARK: - SubUserList
struct SubUserList: Codable {
  let id: Int
  let profileInfo: ProfileInfo
  let name: String
  let kid: Bool
  let parentUser: Int
  
  enum CodingKeys: String, CodingKey {
    case id
    case profileInfo = "profile_info"
    case name, kid
    case parentUser = "parent_user"
  }
}

struct ProfileInfo: Codable {
  let imageID: Int
  let profileImagePath: String
  
  enum CodingKeys: String, CodingKey {
    case imageID = "image_id"
    case profileImagePath = "profile_image_path"
  }
}

// MARK: - RequestMovieElement
struct RequestMovieElement: Codable {
  let mainMovie: MainMovie
  let listOfGenre: [String]
  let moviesByGenre: [String: [MoviesByGenre]]
  
  enum CodingKeys: String, CodingKey {
    case mainMovie = "메인 영화"
    case listOfGenre = "장르리스트"
    case moviesByGenre = "장르별 영화리스트"
  }
}

typealias MainImgCellData = [MainImgCellElement]

// MARK: - MainCellElement
struct MainImgCellElement: Codable {
  let mainMovie: MainMovie
  
  enum CodingKeys: String, CodingKey {
    case mainMovie = "메인 영화"
  }
}


struct MainMovie: Codable {
  let id: Int
  let name, videoFile: String
  let sampleVideoFile, verticalSampleVideoFile: JSONNull?
  let productionDate, uploadedDate, synopsis, runningTime: String
  let viewCount, likeCount: Int
  let logoImagePath: String
  let horizontalImagePath: String
  let verticalImage: String
  let circleImage: JSONNull?
  let bigImagePath: String
  let created: String
  let degree: Degree
  let directors, actors, feature: [Actor]
  let author: [JSONAny]
  let genre: [Actor]
  
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
    case likeCount = "like_count"
    case logoImagePath = "logo_image_path"
    case horizontalImagePath = "horizontal_image_path"
    case verticalImage = "vertical_image"
    case circleImage = "circle_image"
    case bigImagePath = "big_image_path"
    case created, degree, directors, actors, feature, author, genre
  }
}

// MARK: - Actor
struct Actor: Codable {
  let id: Int
  let name: String
}

// MARK: - Degree
struct Degree: Codable {
  let id: Int
  let name: String
  let degreeImagePath: String
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case degreeImagePath = "degree_image_path"
  }
}

// MARK: - 장르별영화리스트
struct MoviesByGenre: Codable {
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

class JSONCodingKey: CodingKey {
  let key: String
  
  required init?(intValue: Int) {
    return nil
  }
  
  required init?(stringValue: String) {
    key = stringValue
  }
  
  var intValue: Int? {
    return nil
  }
  
  var stringValue: String {
    return key
  }
}

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

class JSONAny: Codable {
  
  let value: Any
  
  static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
    let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
    return DecodingError.typeMismatch(JSONAny.self, context)
  }
  
  static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
    let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
    return EncodingError.invalidValue(value, context)
  }
  
  static func decode(from container: SingleValueDecodingContainer) throws -> Any {
    if let value = try? container.decode(Bool.self) {
      return value
    }
    if let value = try? container.decode(Int64.self) {
      return value
    }
    if let value = try? container.decode(Double.self) {
      return value
    }
    if let value = try? container.decode(String.self) {
      return value
    }
    if container.decodeNil() {
      return JSONNull()
    }
    throw decodingError(forCodingPath: container.codingPath)
  }
  
  static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
    if let value = try? container.decode(Bool.self) {
      return value
    }
    if let value = try? container.decode(Int64.self) {
      return value
    }
    if let value = try? container.decode(Double.self) {
      return value
    }
    if let value = try? container.decode(String.self) {
      return value
    }
    if let value = try? container.decodeNil() {
      if value {
        return JSONNull()
      }
    }
    if var container = try? container.nestedUnkeyedContainer() {
      return try decodeArray(from: &container)
    }
    if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
      return try decodeDictionary(from: &container)
    }
    throw decodingError(forCodingPath: container.codingPath)
  }
  
  static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
    if let value = try? container.decode(Bool.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(Int64.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(Double.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(String.self, forKey: key) {
      return value
    }
    if let value = try? container.decodeNil(forKey: key) {
      if value {
        return JSONNull()
      }
    }
    if var container = try? container.nestedUnkeyedContainer(forKey: key) {
      return try decodeArray(from: &container)
    }
    if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
      return try decodeDictionary(from: &container)
    }
    throw decodingError(forCodingPath: container.codingPath)
  }
  
  static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
    var arr: [Any] = []
    while !container.isAtEnd {
      let value = try decode(from: &container)
      arr.append(value)
    }
    return arr
  }
  
  static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
    var dict = [String: Any]()
    for key in container.allKeys {
      let value = try decode(from: &container, forKey: key)
      dict[key.stringValue] = value
    }
    return dict
  }
  
  static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
    for value in array {
      if let value = value as? Bool {
        try container.encode(value)
      } else if let value = value as? Int64 {
        try container.encode(value)
      } else if let value = value as? Double {
        try container.encode(value)
      } else if let value = value as? String {
        try container.encode(value)
      } else if value is JSONNull {
        try container.encodeNil()
      } else if let value = value as? [Any] {
        var container = container.nestedUnkeyedContainer()
        try encode(to: &container, array: value)
      } else if let value = value as? [String: Any] {
        var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
        try encode(to: &container, dictionary: value)
      } else {
        throw encodingError(forValue: value, codingPath: container.codingPath)
      }
    }
  }
  
  static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
    for (key, value) in dictionary {
      let key = JSONCodingKey(stringValue: key)!
      if let value = value as? Bool {
        try container.encode(value, forKey: key)
      } else if let value = value as? Int64 {
        try container.encode(value, forKey: key)
      } else if let value = value as? Double {
        try container.encode(value, forKey: key)
      } else if let value = value as? String {
        try container.encode(value, forKey: key)
      } else if value is JSONNull {
        try container.encodeNil(forKey: key)
      } else if let value = value as? [Any] {
        var container = container.nestedUnkeyedContainer(forKey: key)
        try encode(to: &container, array: value)
      } else if let value = value as? [String: Any] {
        var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
        try encode(to: &container, dictionary: value)
      } else {
        throw encodingError(forValue: value, codingPath: container.codingPath)
      }
    }
  }
  
  static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
    if let value = value as? Bool {
      try container.encode(value)
    } else if let value = value as? Int64 {
      try container.encode(value)
    } else if let value = value as? Double {
      try container.encode(value)
    } else if let value = value as? String {
      try container.encode(value)
    } else if value is JSONNull {
      try container.encodeNil()
    } else {
      throw encodingError(forValue: value, codingPath: container.codingPath)
    }
  }
  
  public required init(from decoder: Decoder) throws {
    if var arrayContainer = try? decoder.unkeyedContainer() {
      self.value = try JSONAny.decodeArray(from: &arrayContainer)
    } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
      self.value = try JSONAny.decodeDictionary(from: &container)
    } else {
      let container = try decoder.singleValueContainer()
      self.value = try JSONAny.decode(from: container)
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    if let arr = self.value as? [Any] {
      var container = encoder.unkeyedContainer()
      try JSONAny.encode(to: &container, array: arr)
    } else if let dict = self.value as? [String: Any] {
      var container = encoder.container(keyedBy: JSONCodingKey.self)
      try JSONAny.encode(to: &container, dictionary: dict)
    } else {
      var container = encoder.singleValueContainer()
      try JSONAny.encode(to: &container, value: self.value)
    }
  }
}
