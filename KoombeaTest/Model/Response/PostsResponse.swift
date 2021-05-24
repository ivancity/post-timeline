//   let postsResponse = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
import Foundation
import CouchbaseLiteSwift

// MARK: - PostsResponse
struct PostsResponse: Codable {
    let data: [PostResponseUser]
}

// MARK: - PostResponseUser
struct PostResponseUser: Codable {
    let uid, name, email: String
    let profilePic: String
    let posts: [IncomingPost]

    enum CodingKeys: String, CodingKey {
        case uid, name, email
        case profilePic = "profile_pic"
        case posts
    }
    
    func postsAsDictionary() -> MutableArrayObject {
        let arrayData = MutableArrayObject()
        for post in posts {
            let dict = post.incomingPostAsDictionary()
            arrayData.addDictionary(MutableDictionaryObject(data: dict))
        }
        return arrayData
    }
}

// MARK: - IncomingPost
struct IncomingPost: Codable {
    let id: Int
    let date: String
    let pics: [String]
    
    func incomingPostAsDictionary() -> [String: Any] {
        return [
            PostKeys.id.rawValue: id,
            PostKeys.date.rawValue: date,
            PostKeys.pics.rawValue: pics
        ]
    }
}
