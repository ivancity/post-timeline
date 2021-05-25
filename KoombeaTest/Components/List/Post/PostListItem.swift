import SwiftUI

struct PostListItem: View {
    var postItem: PostItemModel
    
    var body: some View {
        VStack {
            Text(postItem.date)
            ForEach(postItem.pics, id: \.self) { pic in
                Text(pic)
                    .padding(.vertical, 9)
            }
        }
    }
}

struct PostListItem_Previews: PreviewProvider {
    static var previews: some View {
        PostListItem(postItem: PostItemModel(date: "Jan 2", pics: []))
    }
}
