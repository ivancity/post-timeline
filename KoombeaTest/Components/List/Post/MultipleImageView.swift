import SDWebImageSwiftUI
import SwiftUI

struct MultipleImageView: View {
    let pics: [String]
    let width = UIScreen.main.bounds.size.width
    
    init(pics: [String]) {
        self.pics = pics
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        if pics.count < 3 {
            HStack(alignment: .center, spacing: AppDimensions.imageHorizontalSpacing + 5) {
                ForEach(pics, id: \.self) { pic in
                    WebImage(
                        url: URL(string: pic)
                    )
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: width * 0.42,
                        height: width * 0.42,
                        alignment: .center
                    )
                }
            }
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: AppDimensions.imageHorizontalSpacing + 5) {
                    ForEach(pics, id: \.self) { pic in
                        WebImage(
                            url: URL(string: pic)
                        )
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: width * 0.35,
                            height: width * 0.35
//                            alignment: .center
                        )
                    }
                }
            }
        }
    }
}
