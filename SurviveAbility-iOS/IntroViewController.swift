import UIKit

class IntroViewController: UIViewController {
    
    var captainStore = CaptainStore()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let captainsTableViewController = segue.destination as? CaptainsTableViewController {
            captainsTableViewController.captainStore = captainStore
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = .white
    }

}
