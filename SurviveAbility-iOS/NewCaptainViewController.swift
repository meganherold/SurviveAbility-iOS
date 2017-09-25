import UIKit

class NewCaptainViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var borderView: UIView!
    
    var captainStore: CaptainStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        borderView.layer.borderWidth = 5
        borderView.layer.borderColor = UIColor(red: 255/255, green: 85/255, blue: 86/255, alpha: 1).cgColor
        self.nameTextField.delegate = self;
    }
    
    @IBAction func submitButtonTouched(_ sender: UIButton) {
        if let name = nameTextField.text {
            captainStore.appendNew(captain: Captain(name: name, photo: imageView.image))
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension NewCaptainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
