import SwiftUI

struct UserInTimeline: View {
    var userPost: UserPost
    
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
                                              pics: post.pics)
                )
            }
        }
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        UserInTimeline(userPost: UserPost(uid: "uiduid", name: "John Doe", email: "john@doe.com", profilePic: "https://test.com", posts: []))
    }
}
