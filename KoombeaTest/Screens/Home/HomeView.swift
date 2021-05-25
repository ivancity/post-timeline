import SwiftUI
import CouchbaseLiteSwift
import SwiftUIPullToRefresh

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            RefreshableList(showRefreshView: $viewModel.showRefreshView, action:{
                viewModel.onStartView()
            }){
                if viewModel.userPosts.count < 1 {
                    Text("Unable to find posts at this moment, try again later.")
                        .padding(.horizontal, AppDimensions.horizontalSpacing2)
                        .padding(.vertical, AppDimensions.verticalSpacing3)
                } else {
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
