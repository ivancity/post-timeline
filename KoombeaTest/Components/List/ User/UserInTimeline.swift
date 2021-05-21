import SwiftUI

struct UserInTimeline: View {
    var id: Int
    
    var body: some View {
        Text("POST TEST \(id)")
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        UserInTimeline(id: 33)
    }
}
