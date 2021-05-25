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
    
    func getAllPosts(completion: @escaping((Int) -> Void)) {
        NetworkRequestManager.getAllPosts() { postsResponse in
            guard let response = postsResponse else {
                print("error no response from post endpoint")
                completion(0)
                return
            }
            handlePostsFrom(postsResponse: response, completion: completion)
        }
    }

    private func handlePostsFrom(postsResponse: PostsResponse, completion: @escaping((Int) -> Void)) {
        var counter = 0
        if postsResponse.data.count > 0 {
            clearUserPosts()
        }
        for data in postsResponse.data {
            if add(userPost: data) {
                counter += 1
            }
        }
        completion(counter)
    }
    
    private func add(userPost: PostResponseUser) -> Bool {
        let arrayObject = userPost.postsAsArrayObject()
        let mutableDoc = MutableDocument()
            .setString(userPost.uid, forKey: UserPostKeys.uid.rawValue)
            .setString(userPost.name, forKey: UserPostKeys.name.rawValue)
            .setString(userPost.email, forKey: UserPostKeys.email.rawValue)
            .setString(userPost.profilePic, forKey: UserPostKeys.profilePic.rawValue)
            .setArray(arrayObject, forKey: UserPostKeys.posts.rawValue)
            .setString(DocumentType.user.rawValue, forKey: "type")
        do {
            try database.saveDocument(mutableDoc)
            return true
        } catch {
            print("Error saving document")
            return false
        }
    }
    
    private func clearUserPosts() {
        let query = QueryBuilder
          .select(SelectResult.all(),
                  SelectResult.expression(Meta.id))
          .from(DataSource.database(database))
          .where(Expression.property("type").equalTo(Expression.string(DocumentType.user.rawValue)))
        do {
            for result in try query.execute() {
                guard let idFound = result.string(forKey: "id") else { continue }
                delete(by: idFound)
            }
        } catch {
            print("Something went wrong with clear user posts")
        }
    }
    
    private func delete(by id: String) {
        guard let document = database.document(withID: id) else {
            return
        }
        do {
          try database.deleteDocument(document)
        } catch {
          fatalError("Error deleting document")
        }
    }
    
    func getUserPosts() -> [UserPost] {
      var userPosts: [UserPost] = []

      let query = QueryBuilder
        .select(SelectResult.all(),
                SelectResult.expression(Meta.id))
        .from(DataSource.database(database))
        .where(Expression.property("type").equalTo(Expression.string(DocumentType.user.rawValue)))

      do {
        for result in try query.execute() {
            guard let dict = result.dictionary(forKey: databaseName),
                  let name = dict.string(forKey: UserPostKeys.name.rawValue),
                  let uid = dict.string(forKey: UserPostKeys.uid.rawValue),
                  let email = dict.string(forKey: UserPostKeys.email.rawValue),
                  let profilePic = dict.string(forKey: UserPostKeys.profilePic.rawValue) else {
                  continue
            }
            let posts = generatePostArray(dict: dict)
            let userPost = UserPost(uid: uid, name: name, email: email, profilePic: profilePic, posts: posts)
            userPosts.append(userPost)
        }
      } catch {
        print("Error running the query")
        return []
      }

      return userPosts
    }
    
    private func generatePostArray(dict: DictionaryObject) -> [Post] {
        var posts = [Post]()
        if let userPosts = dict.array(forKey: UserPostKeys.posts.rawValue) {
            for userPost in userPosts {
                guard let dictionaryObject = userPost as? DictionaryObject,
                      let date = dictionaryObject.string(forKey: PostKeys.date.rawValue) else {
                    continue
                }
                let pics = generatePicsArray(dictionaryObject: dictionaryObject)
                let id = dictionaryObject.int(forKey: PostKeys.id.rawValue)
                let post = Post(id: id, date: date, pics: pics)
                posts.append(post)
            }
        }
        return posts
    }
    
    private func generatePicsArray(dictionaryObject: DictionaryObject) -> [String] {
        var pics = [String]()
        if let picsArrayObject = dictionaryObject.array(forKey: PostKeys.pics.rawValue) {
            for picItem in picsArrayObject {
                guard let pic = picItem as? String else {
                    continue
                }
                pics.append(pic)
            }
        }
        return pics
    }
    
}
