//   let postsResponse = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
import Foundation

// MARK: - PostsResponse
struct PostsResponse: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let uid, name, email: String
    let profilePic: String
    let posts: [Post]

    enum CodingKeys: String, CodingKey {
        case uid, name, email
        case profilePic = "profile_pic"
        case posts
    }
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let date: String
    let pics: [String]
}
