import SwiftUI
import SDWebImageSwiftUI

struct PostListItem: View {
    var postItem: PostItemModel
    @Binding var imageSelected: ImageSelectedModel?
    
    var body: some View {
        VStack {
            Text(postItem.date.getAppDateFormatted())
                .fontWeight(.regular)
                .foregroundColor(.black)
                .font(.custom(
                        AppFonts.Primary,
                        size: AppDimensions.smallLabel1))
                .lineSpacing(AppDimensions.lineHeight1)
                .padding(.vertical, AppDimensions.verticalSpacing2)
            if postItem.pics.count == 0 {
                Text("No pics for this day")
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .font(.custom(
                            AppFonts.Primary,
                            size: AppDimensions.smallLabel1))
                    .lineSpacing(AppDimensions.lineHeight1)
                    .padding(AppDimensions.messagePadding)
            } else if postItem.pics.count == 1 {
                SingleImageView(urlString: postItem.pics.first!, imageSelected: $imageSelected)
            } else if postItem.pics.count == 2 {
                MultipleImageView(pics: postItem.pics)
            } else if postItem.pics.count == 3 {
                VStack {
                    SingleImageView(urlString: postItem.pics.first!, imageSelected: $imageSelected)
                    MultipleImageView(pics: Array(postItem.pics.dropFirst()))
                        .padding(.top, AppDimensions.verticalSpacing1)
                }
            } else if postItem.pics.count >= 4 {
                VStack {
                    SingleImageView(urlString: postItem.pics.first!, imageSelected: $imageSelected)
                    MultipleImageView(pics: Array(postItem.pics.dropFirst()))
                        .padding(.top, AppDimensions.verticalSpacing1)
                }
            }
        }
    }
}
