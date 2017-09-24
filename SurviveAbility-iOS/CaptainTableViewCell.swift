import UIKit

class CaptainTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.adjustsFontForContentSizeCategory = true
    }

}
