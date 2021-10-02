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
        self.setupObserver()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupDelegates()
        self.setupProperties()
        self.setupConfiguration()
        self.setupObserver()
    }

    deinit {
        self.resetObserver()
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

    private func setupObserver() {
        let keyPath = #keyPath(WKWebView.isLoading)
        self.addObserver(self, forKeyPath: keyPath, options: [.new, .initial], context: nil)
    }

    private func resetObserver() {
        let keyPath = #keyPath(WKWebView.isLoading)
        self.removeObserver(self, forKeyPath: keyPath)
    }

    private static let javaScriptMessageName = ""

}

extension DaengnyangWebView {

    private enum MessageName: String, CaseIterable {
        case close
    }

}

extension DaengnyangWebView: WKScriptMessageHandler {

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
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
