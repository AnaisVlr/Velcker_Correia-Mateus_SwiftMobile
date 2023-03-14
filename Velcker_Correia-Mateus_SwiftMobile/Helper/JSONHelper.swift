//
//  JSONHelper.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation


struct JSONHelper{
   static func loadFromFile(name:String, extension: String) async -> Data?{
      guard let fileURL = Bundle.main.url(forResource: "playlist", withExtension: "json") else { return nil }
      guard let fileContents = try? Data(contentsOf: fileURL) else { return nil }
      return fileContents
   }
   
   static func decode<T: Decodable>(data: Data) async -> T?{
      let decoder = JSONDecoder()
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
