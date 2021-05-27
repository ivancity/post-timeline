import Foundation

class HomeViewModel: ObservableObject {
    
    let mainRepo = MainRepo()
    
    @Published var userPosts: [UserPost] = []
    @Published var showRefreshView = false
    @Published var imageSelected: ImageSelectedModel? {
        didSet {
            if let imageSelected = imageSelected {
                print("test \(imageSelected.imageUrl)")
            } else {
                print("clearing image selected")
            }
            
        }
    }
    
    func handleOnAppear() {
        if loadUI() < 1 {
            onStartView()
        }
    }
    
    func onStartView() {
        showRefreshView = true
        mainRepo.getAllPosts() {[weak self] counter in
            guard counter > 0 else {
                // TODO we might want to show an error messsage here, or do something else before loading data back to the UI
                let _ = self?.loadUI()
                self?.showRefreshView = false
                return
            }
            let _ = self?.loadUI()
            self?.showRefreshView = false
        }
    }
    
    func loadUI() -> Int {
        self.userPosts = mainRepo.getUserPosts()
        return self.userPosts.count
    }
}
