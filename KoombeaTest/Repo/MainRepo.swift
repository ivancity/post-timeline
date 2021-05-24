import Foundation
import CouchbaseLiteSwift

struct MainRepo {
    static let shared = MainRepo()
    
    private let database: Database
    private let databaseName = "koombea-db"
    
    init() {
        do {
            database = try Database(name: databaseName)
        } catch {
            fatalError("Error opening database")
        }
    }
    
    func getAllPosts() {
        NetworkRequestManager.getAllPosts() { postsResponse in
            print("incoming from network")
            guard let response = postsResponse else {
                print("error no response from post endpoint")
                return
            }
            handlePostsFrom(postsResponse: response)
        }
    }

    private func handlePostsFrom(postsResponse: PostsResponse) {
        for data in postsResponse.data {
            add(userPost: data)
        }
    }
    
    private func add(userPost: PostResponseUser) {
        let arrayObject = MutableArrayObject.init(data: userPost.posts)
        let mutableDoc = MutableDocument()
            .setString(userPost.uid, forKey: UserPostKeys.uid.rawValue)
            .setString(userPost.name, forKey: UserPostKeys.name.rawValue)
            .setString(userPost.email, forKey: UserPostKeys.email.rawValue)
            .setString(userPost.profilePic, forKey: UserPostKeys.profilePic.rawValue)
            .setArray(arrayObject, forKey: UserPostKeys.posts.rawValue)
            .setString(DocumentType.user.rawValue, forKey: "type")

        do {
          try database.saveDocument(mutableDoc)
        } catch {
          fatalError("Error saving document")
        }
    }
    
}
