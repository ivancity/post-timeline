import Foundation
import CouchbaseLiteSwift

struct MainRepo {
    static let shared = MainRepo()
    
    private let database: Database
    private let databaseName = "koombea-db"
    
    private init() {
        do {
            database = try Database(name: databaseName)
        } catch {
            fatalError("Error opening database")
        }
        
    }
    
    

    
}
