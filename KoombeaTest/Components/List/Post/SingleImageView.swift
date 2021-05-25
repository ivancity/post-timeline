import SDWebImageSwiftUI
import SwiftUI

struct SingleImageView: View {
    let urlString: String
    var body: some View {
        WebImage(
            url: URL(string: urlString)
        )
        .resizable()
        .scaledToFill()
        .frame(
            maxWidth: .infinity,
            alignment: .center
        )
    }
}
