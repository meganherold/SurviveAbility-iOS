import UIKit

class NewCaptainViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var borderView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        borderView.layer.borderWidth = 5
        borderView.layer.borderColor = UIColor(red: 255/255, green: 85/255, blue: 86/255, alpha: 1).cgColor
        self.nameTextField.delegate = self;
        
        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewCaptainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
