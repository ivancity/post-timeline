import Alamofire
import Foundation
class NetworkRequestManager {
    public static let domain = "https://mock.koombea.io/"
    public static let api = "mt/api/"
    
    static func getAllPosts(completion: @escaping((PostsResponse?) -> Void)) {
        let postsApi = "\(domain)\(api)users/posts"
        AF.request(postsApi).responseJSON { response in
            switch response.result {
            case .success:
                guard let incomingData = response.data else {
                    completion(nil)
                    return
                }
                let decoder = JSONDecoder()
                let decodedResponse = try? decoder.decode(PostsResponse.self, from: incomingData)
                completion(decodedResponse)
            case .failure:
                completion(nil)
            }
        }
    }
}
