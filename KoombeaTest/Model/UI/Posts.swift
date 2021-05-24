import Foundation

struct UserPost {
    let uid, name, email: String
    let profilePic: String
    let posts: [Post]
}

struct Post {
    let id: Int
    let date: String
    let pics: [String]
}
