import SwiftUI
import CouchbaseLiteSwift
import SwiftUIPullToRefresh

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                RefreshableList(showRefreshView: $viewModel.showRefreshView, action:{
                    viewModel.onStartView()
                }){
                    if viewModel.userPosts.count < 1 {
                        Text("Unable to find posts at this moment, try again later.")
                            .padding(.horizontal, AppDimensions.horizontalSpacing2)
                            .padding(.vertical, AppDimensions.verticalSpacing3)
                    } else {
                        ForEach(self.viewModel.userPosts){ userPost in
                            UserInTimeline(userPost: userPost) { imageSelected in
                                viewModel.imageSelected = imageSelected
                            }
                        }
                    }
                }
                .disabled(viewModel.imageSelected == nil ? false : true)
                .blur(radius: viewModel.imageSelected != nil ? 20 : 0)
                if let _ = viewModel.imageSelected {
                    ImageDetailView(imageSelected: $viewModel.imageSelected)
                        .transition(.move(edge: .bottom))
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
