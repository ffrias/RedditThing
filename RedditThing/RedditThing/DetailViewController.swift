import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var loadingLabel: UILabel!
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        if(url.characters.count > 0) {
            loadURL(self.url)
        }
    }
    
    func loadURL(_ url:String) {
        
        print("DVC - loadURL: \(url)")
        
        self.url = url
        
        // Load URL if the web view has been initialized and the url is ready
        if let webView = self.webView {
            
            webView.isHidden = true
            loadingLabel.isHidden = false
            
            let requestURL = URL(string:url)
            let request = URLRequest(url: requestURL!)
            webView.loadRequest(request)
        }
    }
    
    // ----------------------------------
    // MARK: UIWebVIewDelegate
    // ----------------------------------
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.isHidden = false
        loadingLabel.isHidden = true
    }
}



























