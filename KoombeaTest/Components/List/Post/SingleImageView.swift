import SDWebImageSwiftUI
import SwiftUI

struct SingleImageView: View {
    let urlString: String
    @Binding var imageSelected: ImageSelectedModel?
    
    var body: some View {
        Button(action: {
            imageSelected = ImageSelectedModel(imageUrl: urlString)
        }) {
            WebImage(
                url: URL(string: urlString)
            )
            .resizable()
            .scaledToFill()
            .frame(
                maxWidth: .infinity,
                alignment: .center
            )
        }    }
}
