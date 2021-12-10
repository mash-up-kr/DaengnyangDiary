//
//  DaengnyangWebView.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/03.
//

import UIKit
import WebKit

final class DaengnyangWebView: WKWebView {

    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        self.setupDelegates()
        self.setupProperties()
        self.setupConfiguration()
        self.updateToken()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupDelegates()
        self.setupProperties()
        self.setupConfiguration()
        self.updateToken()
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        let isDetach = newSuperview == nil
        isDetach ? self.removeScriptMessage() : self.addScriptMessage()
    }

    private func removeScriptMessage() {
        let controller = self.configuration.userContentController
        MessageName.allCases.forEach {
            controller.removeScriptMessageHandler(forName: $0.rawValue)
        }
        controller.removeScriptMessageHandler(forName: Self.javaScriptMessageName)
    }

    private func addScriptMessage() {
        let controller = self.configuration.userContentController
        MessageName.allCases.forEach {
            controller.add(self, name: $0.rawValue)
        }
        controller.add(self, name: Self.javaScriptMessageName)
    }

    private func setupDelegates() {
        self.scrollView.contentInsetAdjustmentBehavior = .never
    }

    private func setupProperties() {
        self.navigationDelegate = self
        self.allowsBackForwardNavigationGestures = true
    }

    private func setupConfiguration() {
        self.configuration.allowsInlineMediaPlayback = true
        self.configuration.mediaTypesRequiringUserActionForPlayback = []
        self.configuration.userContentController = WKUserContentController()
    }

    func updateToken() {
//        guard let token = UserDataController.token else { return }
        let jsSource =
        """
        Mobile = {
            getToken() {
                return "\(1234567890)";
            }
        }
        """
        self.evaluateJavaScript(jsSource, completionHandler: nil)
    }

    private static let javaScriptMessageName = ""

}

extension DaengnyangWebView {

    private enum MessageName: String, CaseIterable {
        case close
        case reload
        case delete
        case addBookmark
    }

}

extension DaengnyangWebView: WKScriptMessageHandler {

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("DaengnyangWebView didReceive message: \(message.name)")
    }

}

extension DaengnyangWebView: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

}

extension DaengnyangWebView: WKUIDelegate {
}
