import SwiftUI
import SDWebImageSwiftUI

struct ImageItemView: View {
    let picUriString: String
    let size: CGFloat
    let imageSelected: (ImageSelectedModel) -> ()
    
    private let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        Button(action: {
            imageSelected(ImageSelectedModel(imageUrl: picUriString))
        }) {
            WebImage(
                url: URL(string: picUriString)
            )
            .resizable()
            .scaledToFill()
            .frame(
                width: width * size,
                height: width * size,
                alignment: .center
            )
        }
        
    }
}
