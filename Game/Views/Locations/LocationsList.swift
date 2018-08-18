import UIKit
import Magic
import RealmSwift

class LocationsList: UITableViewController {
  
  let locations = realm.objects(Location.self)
  var selectedLocation: Location?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return locations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "locationIdentifier", for: indexPath)
    
    cell.detailTextLabel?.text = locations[indexPath.row].name
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let location = locations[indexPath.row]
    performSegue(withIdentifier: "toLocationScreen", sender: location)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    magic("hello?")
  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let destination = segue.destination as? LocationScreen {
//      if let selectedLocation = sender as? Location {
//        magic("Message for 'If'")
//        destination.location = selectedLocation
//      } else {
//        magic("Message for 'Else'")
//      } 
//    }
//  }
}
