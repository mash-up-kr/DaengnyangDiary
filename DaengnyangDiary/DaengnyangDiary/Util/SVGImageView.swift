//
//  SVGImageView.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/12/10.
//

import UIKit

public class SVGImageView: UIView {
    private let webView = UIWebView()

    public init() {
        super.init(frame: .zero)
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        webView.contentMode = .scaleAspectFit
        webView.backgroundColor = .clear
        addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        webView.stopLoading()
    }

    public func load(url: String) {
        webView.stopLoading()
        if let url = URL(string: url) {
            webView.loadRequest(URLRequest(url: url))
        }
    }
}

extension SVGImageView: UIWebViewDelegate {
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        let scaleFactor = webView.bounds.size.width / webView.scrollView.contentSize.width
        if scaleFactor <= 0 {
            return
        }

        webView.scrollView.minimumZoomScale = scaleFactor
        webView.scrollView.maximumZoomScale = scaleFactor
        webView.scrollView.zoomScale = scaleFactor
    }
}
