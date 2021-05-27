import SDWebImageSwiftUI
import SwiftUI

struct ImageDetailView: View {
    @Binding var imageSelected: ImageSelectedModel?
    @State private var urlToShow: String?
    @State private var offset = CGSize.zero
    let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack {
            if let _ = imageSelected, let urlToShow = urlToShow {
                WebImage(
                    url: URL(string: urlToShow)
                )
                .resizable()
                .scaledToFill()
                .frame(
                    width: width * 0.8,
                    height: width * 0.8,
                    alignment: .center
                )
                .offset(x:0, y: offset.height > 0 ? offset.height * 5 : 0)
                .opacity(offset.height > 0 ? 2 - Double(abs(offset.height/50)) : 1)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = gesture.translation
                        }
                        .onEnded { _ in
                            if self.offset.height > 100 {
                                imageSelected = nil
                            } else {
                                self.offset = .zero
                            }
                        }
                )
            } else {
                EmptyView()
            }
        }
        .onAppear {
            if let imageSelected = imageSelected {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    urlToShow = imageSelected.imageUrl
                }
            }
        }
        
    }
}
