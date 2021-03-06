import SDWebImageSwiftUI
import SwiftUI

struct MultipleImageView: View {
    let pics: [String]
    let imageSelected: (ImageSelectedModel) -> ()
    
    private let width = UIScreen.main.bounds.size.width
    
    init(pics: [String],
         imageSelected: @escaping(ImageSelectedModel) -> ()) {
        self.pics = pics
        self.imageSelected = imageSelected
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        if pics.count < 3 {
            HStack(alignment: .center, spacing: AppDimensions.imageHorizontalSpacing + 5) {
                ForEach(pics, id: \.self) { pic in
                    ImageItemView(
                        picUriString: pic,
                        size: AppDimensions.imageRegular,
                        imageSelected: imageSelected)
                }
            }
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: AppDimensions.imageHorizontalSpacing + 5) {
                    ForEach(pics, id: \.self) { pic in
                        ImageItemView(
                            picUriString: pic,
                            size: AppDimensions.imageSmall,
                            imageSelected: imageSelected)
                    }
                }
            }

        }
    }
}
