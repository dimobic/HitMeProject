import UIKit

class AboutViewController: UIViewController {

    lazy var Text: UITextView = {
        let text =  UITextView()
        text.text = "*** Bull’s Eye *** \n      Welcome to the awesome game of Bull’s Eye where you can win points and fame by dragging a slider. \n    Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score. Enjoy!"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isEditable = false
        text.allowsEditingTextAttributes = false
        text.font = UIFont.systemFont(ofSize: 27.0)
        return text
    }()
    @objc func CancelTap(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CancelTap))
        addSubviews()
        setupConstraints()
    }
    func addSubviews() {
        self.view.addSubview(Text)
    }
    func setupConstraints() {
        Text.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        Text.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        Text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Text.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
}
