import SwiftUI
import SDWebImageSwiftUI

struct ItemHeader: View {
    var userHeader: UserHeader
    var body: some View {
        HStack {
            WebImage(
                url: URL(string: userHeader.imageUrl)
            )
            .resizable()
            .scaledToFill()
            .frame(
                width: AppDimensions.headerImage,
                height: AppDimensions.headerImage,
                alignment: .center
            )
            .clipShape(Circle())
            .padding(.vertical, AppDimensions.verticalSpacing1)
            .padding(.trailing, AppDimensions.horizontalSpacing1)
            VStack(alignment: .leading) {
                Text(userHeader.name)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .font(.custom(
                            AppFonts.Primary,
                            size: AppDimensions.smallLabel2))
                    .lineSpacing(AppDimensions.lineHeight2)
                Text(userHeader.email)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .font(.custom(
                            AppFonts.Primary,
                            size: AppDimensions.smallLabel1))
                    .lineSpacing(AppDimensions.lineHeight1)
            }
        }
        
    }
}

struct ItemHeader_Previews: PreviewProvider {
    static var previews: some View {
        ItemHeader(userHeader: UserHeader(imageUrl: "https://mock.koombea.io/profile/profile5.jpg", name: "John Doe", email: "john@doe.com"))
    }
}
