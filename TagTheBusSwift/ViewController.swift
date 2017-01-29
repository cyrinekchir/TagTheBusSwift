import UIKit
import Alamofire

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{

    var stationsList: [Station] = []
    var filteredStations: [Station] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    
    
    

    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let keywords = searchBar.text
         if let ch = keywords {
        filteredStations = stationsList.filter({( station : Station) -> Bool in
            
            return  (station.streetName?.lowercased().contains((ch.lowercased())))!
        })
        if(filteredStations.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        }
        self.tableView.reloadData()
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         searchBar.delegate = self
        
        Alamofire.request("http://barcelonaapi.marcpous.com/bus/nearstation/latlon/41.3985182/2.1917991/1.json").responseJSON { response in
                if let JSON = response.result.value{
                        let info = JSON as! NSDictionary
                            if let data=info["data"]as? NSDictionary{
                                    let stations = data["nearstations"] as! NSArray
                                        for index in 1...stations.count-1 {
                                                let jsonData = stations[index]as! NSDictionary
                                                let station=Station()
                                                station.fetchStation(dictionary: jsonData)
                                                self.stationsList.append(station)
                                        }
                                self.tableView.reloadData()
                            }
                
                }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if  (searchActive){
            return filteredStations.count
        }
        
        return stationsList.count
    }
    
    
   
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath) as! StationCell
        
        
        
        let station: Station
        if  (searchActive) {
            station = filteredStations[indexPath.row]
        } else {
            station = stationsList[indexPath.row]
        }
        
        cell.nameLabel.text = station.streetName
        cell.cityLabel.text =  station.city
        
        return cell
        
    }
    
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stationDetail" ,
            let nextScene = segue.destination as? StationDetailController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedStation = stationsList[indexPath.row]
            nextScene.currentStation = selectedStation
        }
    
    }
        
        


}

