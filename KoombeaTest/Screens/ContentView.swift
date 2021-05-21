import SwiftUI
import CouchbaseLiteSwift
import SwiftUIPullToRefresh

struct ContentView: View {
    @State var numbers:[Int] = [23,45,76,54,76,3465,24,423]
    @State var showRefreshView: Bool = false
    
    var body: some View {
        RefreshableList(showRefreshView: $showRefreshView, action:{
            self.numbers = self.generateRandomNumbers()
            // Remember to set the showRefreshView to false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showRefreshView = false
            }
        }){
            ForEach(self.numbers, id: \.self){ number in
                VStack(alignment: .leading){
                    UserInTimeline(id: number)
                }
            }
        }
    }
    
    func generateRandomNumbers() -> [Int] {
        var sequence = [Int]()
        for _ in 0...30 {
            sequence.append(Int.random(in: 0 ..< 100))
        }
        return sequence
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
