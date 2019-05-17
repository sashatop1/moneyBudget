import UIKit


class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension BaseController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
