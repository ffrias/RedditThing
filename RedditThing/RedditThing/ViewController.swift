import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    //Para resolver lo pedido voy a usar el PATRON OBSERVER. En donde voy a registrar una notificacion la cual voy a recibir una vez que la data de la API sea traida, con lo cual voy a refrezcar la tabla para mostrar esos resultados almacenados en RedditClient.

    @IBOutlet var tableView: UITableView!
    
    // ----------------------------------
    // MARK: VIEW LIFE CYCLE
    // ----------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RedditClient.instance.getData()
        
        tableView.dataSource = self
        
        //Registro el objeto (self) para poder recibir notificaciones (como observer).
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.onRedditDataFetched), name: .dataFetchedFromApiNotification, object: nil)
    }
    
    // ----------------------------------
    // MARK: NOTIFICATIONS
    // ----------------------------------
    
    func onRedditDataFetched() {
        tableView.reloadData()
    }
    
    // ----------------------------------
    // MARK: UITableViewDataSource
    // ----------------------------------
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RedditClient.instance.reddits.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellView") as! CellView
        
        let reddit = RedditClient.instance.reddits[indexPath.row]
        
        cell.loadData(title: reddit.title, author: reddit.author, isFavorite: reddit.isFavorite)
        print("cellForRowAt() - isFavorite: \(reddit.isFavorite)")
        
        return cell
    }
    
    //Uso segues para mandar data.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToDetailSegue"){
        let indexPath = tableView.indexPathForSelectedRow!
        let url = RedditClient.instance.reddits[indexPath.row].url
        let DetailViewController = segue.destination as! DetailViewController
        DetailViewController.loadURL(url)
        }
    }
}




























