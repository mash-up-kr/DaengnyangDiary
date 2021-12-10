//
//  WebContainerViewController.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/03.
//

import UIKit
import WebKit

final class WebContainerViewController: UIViewController {

    @IBAction func test(_ sender: UIButton) {
        self.webView?.updateToken()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWebView()
    }

    func configure(urlPath: String) {
        self.urlPath = urlPath
    }

    private func setupWebView() {
        guard let urlPath = self.urlPath else { return }
        guard let url = URL(string: urlPath) else { return }
        let urlRequest = URLRequest(url: url)
        self.webView?.load(urlRequest)
    }

    private func setupCustomUserAgent() {
        self.webView?.customUserAgent = ""
    }

    private var urlPath: String? = "https://eclass-webview.netlify.app/monthly-diary"

    @IBOutlet private weak var webView: DaengnyangWebView?

}
