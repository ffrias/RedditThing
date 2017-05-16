import UIKit
import SwiftyJSON

class Reddit: NSObject {
    
   // ------------------------------------------
    // MARK: PROPERTIES
    // ------------------------------------------
    
    var title:String = ""
    var author:String = ""
    var url:String = ""
    var isFavorite:Bool = false
    
    // ------------------------------------------
    // MARK: INIT
    // ------------------------------------------
    init(json:JSON) {
        
        let data = json["data"]
        
        self.title = data["title"].stringValue
        self.author = data["author"].stringValue
        self.url = data["url"].stringValue
        // ...
    }
}




























