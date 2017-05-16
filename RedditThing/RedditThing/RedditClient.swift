import Foundation
import SwiftyJSON

class RedditClient: NSObject {
    
    // ----------------------------------
    // MARK: PROPERTIES
    // ----------------------------------
    
    static let instance = RedditClient()
    
    var reddits:[Reddit] = []
    
    // ----------------------------------
    // MARK: API CALLS
    // ----------------------------------
    
    func getData() {
        
        print("RedditClient - getRedditData()...")
        
        // Construct GET request.
        let requestURL = URL(string:"http://www.reddit.com/top/.json?limit=50")!
        let request = NSMutableURLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // Async GET
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            print("RedditClient - Data retrieved.")
            
            if error != nil {
                print("error retrieving data")
                return
            }
            
            let json = JSON(data: data!)
//            print("json: \(json)")
            
            let reddits = json["data"]["children"]
            for (_, entry) in reddits {
                let reddit = Reddit(json: entry)
                self.reddits.append(reddit)
            }
            
            //Posteo una notificacion en el main  thread cuando termino de traer la data, ya que estoy en background y quiero hacer updates en UI.
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .dataFetchedFromApiNotification, object: nil)
            }
        }) 
        task.resume()
    }
}


//Creo una extension para Notification.Name y definir el identificador para la notificacion.
extension Notification.Name{
    static let dataFetchedFromApiNotification = Notification.Name("dataFetchedFromApiNotification")
}
