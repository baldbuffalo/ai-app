import SwiftUI
import WebKit

final class ClaudeAutomator: NSObject, ObservableObject {
    let webView: WKWebView
    @Published var status = "loading"
    @Published var response = ""

    override init() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        super.init()
        webView.load(URLRequest(url: URL(string: "https://claude.ai")!))
    }

    func send(_ prompt: String) {
        let p = prompt
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
            .replacingOccurrences(of: "\n", with: "\\n")
        let js = """
        (function(p){
          const ed = document.querySelector('div[contenteditable="true"]');
          if(!ed){return 'no-editor';}
          ed.focus();
          document.execCommand('insertText', false, p);
          const btn = document.querySelector('button[aria-label="Send message"]');
          if(btn){btn.click(); return 'sent';}
          ed.dispatchEvent(new KeyboardEvent('keydown',{key:'Enter',bubbles:true}));
          return 'sent-enter';
        })("\(p)");
        """
        webView.evaluateJavaScript(js) { [weak self] r, _ in
            self?.status = (r as? String) ?? "error"
        }
    }

    func readLatest() {
        let js = """
        (function(){
          const n = document.querySelectorAll('[data-testid="assistant-message"], .font-claude-message');
          return n.length ? n[n.length-1].innerText : '';
        })();
        """
        webView.evaluateJavaScript(js) { [weak self] r, _ in
            self?.response = (r as? String) ?? ""
        }
    }
}

struct WebViewContainer: UIViewRepresentable {
    let webView: WKWebView
    func makeUIView(context: Context) -> WKWebView { webView }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
