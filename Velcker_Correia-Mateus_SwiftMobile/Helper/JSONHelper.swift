//
//  JSONHelper.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation

enum DateError: String, Error {
  case invalidDate
}

struct JSONHelper{
  static func loadFromFile(name:String, extension: String) async -> Data?{
    guard let fileURL = Bundle.main.url(forResource: "playlist", withExtension: "json") else { return nil }
    guard let fileContents = try? Data(contentsOf: fileURL) else { return nil }
    return fileContents
  }
   
  static func decode<T: Decodable>(data: Data) async -> T?{
    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
      let container = try decoder.singleValueContainer()
      let dateStr = try container.decode(String.self)

      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
      if let date = formatter.date(from: dateStr) {
        return date
      }
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
      if let date = formatter.date(from: dateStr) {
        return date
      }
      throw DateError.invalidDate
    })
    guard let decoded = try? decoder.decode(T.self, from: data) else {
      return nil
    }
    return decoded
  }
  static func decodePasAsync<T: Decodable>(data: Data) -> T?{
    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
      let container = try decoder.singleValueContainer()
      let dateStr = try container.decode(String.self)

      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
      if let date = formatter.date(from: dateStr) {
        return date
      }
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
      if let date = formatter.date(from: dateStr) {
        return date
      }
      throw DateError.invalidDate
    })
    guard let decoded = try? decoder.decode(T.self, from: data) else {
      return nil
    }
    return decoded
  }
  static func encode<T: Encodable>(data: T) async -> Data?{
    let encoder = JSONEncoder()
    return try? encoder.encode(data)
  }
}

//struct AppleMusicHelper{
//   struct ResultDTO : Decodable{
//      var resultCount: Int
//      var results: [TrackDTO]
//   }
//   static func decode(data: Data) async -> [TrackDTO]?{
//      let decoder = JSONDecoder()
//      guard let decoded = try? decoder.decode(Self.ResultDTO, from: data) else {
//         return nil
//      }
//      return decoded.results
//   }
//
//}
