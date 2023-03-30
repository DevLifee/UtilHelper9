//
//  File.swift
//  
//
//  Created by DanHa on 31/03/2023.
//


import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct TenCoor : UIViewRepresentable {
    func makeCoordinator() -> TenCoorClss {
        TenCoorClss(self)
    }
    
    let url: URL?

    @Binding var getHtmAdten: String
    var listData: [String: String] = [:]

    private let tenObs = TenObs()
    var tenobserver: NSKeyValueObservation? {
        tenObs.tenins
    }
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = listData[RemoKey.rm02ch.rawValue] ?? ""
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView,context:Context){ }
    
    class TenCoorClss : NSObject, WKNavigationDelegate {
        var prentTenCoor: TenCoor
        init(_ prentTenCoor: TenCoor) {
            self.prentTenCoor = prentTenCoor
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                webView.evaluateJavaScript(self.prentTenCoor.listData[RemoKey.outer1af.rawValue] ?? "") { data, error in
                    if let htm = data as? String, error == nil {
                        if !htm.isEmpty{
                            if htm.contains(self.prentTenCoor.listData[RemoKey.status1af.rawValue] ?? ""){
                                self.prentTenCoor.getHtmAdten = htm
                            }
                        }
                    }
                }
            }
        }
    }
}
private class TenObs: ObservableObject {
    @Published var tenins: NSKeyValueObservation?
}
