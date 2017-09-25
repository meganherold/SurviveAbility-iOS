import UIKit

class CaptainsTableViewController: UITableViewController {
    
    var captainStore: CaptainStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return captainStore.allCaptains.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CaptainPhotoViewController {
            controller.captainStore = captainStore
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "captainCell", for: indexPath) as! CaptainTableViewCell

        let captain = captainStore.allCaptains[indexPath.row]
        cell.nameLabel.text = captain.name

        return cell
    }

}
