import Foundation

struct UserPost: Identifiable {
    let id = UUID()
    let uid, name, email: String
    let profilePic: String
    let posts: [Post]
}

struct Post: Identifiable {
    let id: Int
    let date: String
    let pics: [String]
}
