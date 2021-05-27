import SwiftUI

struct UserInTimeline: View {
    var userPost: UserPost
    @Binding var imageSelected: ImageSelectedModel?
    
    var body: some View {
        VStack(alignment: .center) {
            ItemHeader(userHeader: UserHeader(
                        imageUrl: userPost.profilePic,
                        name: userPost.name,
                        email: userPost.email)
            )
            ForEach(userPost.posts) { post in
                PostListItem(postItem:
                                PostItemModel(date: post.date,
                                              pics: post.pics),
                             imageSelected: $imageSelected
                )
            }
        }
    }
}
