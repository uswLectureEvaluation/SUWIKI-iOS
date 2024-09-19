//
//  DTO+PurchasedExamPostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

import Common
import Domain

extension DTO {
  public struct FetchPurchasedExamPostsResponse: Decodable {
    public let posts: [PurchasedExamPosts]
    public let statusCode: Int?
    public let message: String?
    
    public init(
      posts: [PurchasedExamPosts],
      statusCode: Int?,
      message: String?
    ) {
      self.posts = posts
      self.statusCode = statusCode
      self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
      case posts = "data"
      case statusCode
      case message
    }
  }
}

extension DTO.FetchPurchasedExamPostsResponse {
  public struct PurchasedExamPosts: Decodable {
    public let id: Int
    public let professor: String
    public let lectureName: String
    public let majorType: String
    public let createDate: String
    
    public init(
      id: Int,
      professor: String,
      lectureName: String,
      majorType: String,
      createDate: String
    ) {
      self.id = id
      self.professor = professor
      self.lectureName = lectureName
      self.majorType = majorType
      self.createDate = createDate
    }
    
    var entity: PurchasedPost {
      PurchasedPost(id: id,
                    name: lectureName,
                    date: createDate.formatDate())
    }
  }
}
