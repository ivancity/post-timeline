import SwiftUI
import SDWebImageSwiftUI

struct PostListItem: View {
    var postItem: PostItemModel
    
    var body: some View {
        VStack {
            Text(postItem.date.getAppDateFormatted())
                .fontWeight(.regular)
                .foregroundColor(.black)
                .font(.custom(
                        AppFonts.Primary,
                        size: AppDimensions.smallLabel1))
                .lineSpacing(AppDimensions.lineHeight1)
            
            if postItem.pics.count == 0 {
                Text("No pics for this day")
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .font(.custom(
                            AppFonts.Primary,
                            size: AppDimensions.smallLabel1))
                    .lineSpacing(AppDimensions.lineHeight1)
            } else if postItem.pics.count == 1 {
                WebImage(
                    url: URL(string: postItem.pics.first!)
                )
                .resizable()
                .scaledToFill()
                .frame(
                    maxWidth: .infinity,
                    alignment: .center
                )
            } else if postItem.pics.count == 2 {
                Text("2 boxes")
            } else if postItem.pics.count == 3 {
                Text("3 boxes")
            } else if postItem.pics.count >= 4 {
                Text("4 boxes plus")
            }
                
//            ForEach(postItem.pics, id: \.self) { pic in
//                Text(pic)
//                    .padding(.vertical, 9)
//            }
        }
    }
}

struct PostListItem_Previews: PreviewProvider {
    static var previews: some View {
        PostListItem(postItem: PostItemModel(date: "Jan 2", pics: []))
    }
}
