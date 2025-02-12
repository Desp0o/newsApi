//
//  ViewModel.swift
//  19. web services
//
//  Created by Despo on 30.10.24.
//
import Foundation
import NetworkManagerFramework
import DateFormatterFramework

protocol UpdateNewsDelegate: AnyObject {
  func updateNewsFeed()
}

final class ViewModel {
  weak var delegate: UpdateNewsDelegate?
  private let dateFormatter: DateFormatProtocol
  private let networkService: NetworkServiceProtocol
  private var currentPage = 0
  
  init(dateFormatter: DateFormatProtocol = DateFormat(), networkService: NetworkServiceProtocol = NetworkService()) {
    self.dateFormatter = dateFormatter
    self.networkService = networkService
    loadNextPage()
  }
  
  var newsArray: [SinglePost] = []
  
  var newsCount: Int {
    newsArray.count
  }
  
  func singlePost(index: Int) -> SinglePost {
    return newsArray[index]
  }
  
  func loadNextPage() {
    currentPage += 1
    let linkApi = "https://newsapi.org/v2/everything?q=bitcoin&pageSize=10&page=\(currentPage)&apiKey=9670879ea1df4f23b16aa2e834f82a66"
    
    Task {
      do {
        let response: NewsResponseData = try await networkService.fetchData(urlString: linkApi)
        
        var finalData = response.articles
        
        finalData.removeAll { post in
          post.title == "[Removed]"
        }
        
        finalData = finalData.map {[weak self] post in
          var updatedPost = post
          updatedPost.publishedAt = self?.dateFormatter.formatDate(date: post.publishedAt) ?? post.publishedAt
          return updatedPost
        }
        
        self.newsArray.append(contentsOf: finalData)
        
        await MainActor.run {
          delegate?.updateNewsFeed()
        }
      }
    }
  }
}
