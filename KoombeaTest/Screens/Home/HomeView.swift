import SwiftUI
import CouchbaseLiteSwift
import SwiftUIPullToRefresh

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            if viewModel.userPosts.count < 1 {
                Text("Unable to find posts at this moment, try again later.")
                    .padding(.horizontal, 10)
            } else {
                RefreshableList(showRefreshView: $viewModel.showRefreshView, action:{
                    // Remember to set the showRefreshView to false
                    viewModel.onStartView()
                }){
                    ForEach(self.viewModel.userPosts){ userPost in
                        VStack(alignment: .leading){
                            UserInTimeline(userPost: userPost)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .onAppear {
            viewModel.handleOnAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
