struct Source: Codable {
    let id: String?
    let name: String
}

struct SinglePost: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    var publishedAt: String
    let content: String?
}

struct NewsResponseData: Codable {
    var status: String
    var totalResults: Int
    var articles: [SinglePost]
}
