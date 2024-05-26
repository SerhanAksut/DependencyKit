
import FeatureStore
import FeatureInterface
import UIKit

final class FirstFeatureViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .cyan
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.backgroundColor = . white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Open Second Feature", for: .normal)
        button.addTarget(self, action: #selector(didTapOpenButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    @objc func didTapOpenButton() {
        let controller = FeatureStore.shared.secondFeature.build(delegate: self)
        present(controller, animated: true)
    }
}

extension FirstFeatureViewController: SecondFeatureCloseButtonDelegate {
    func didTapCloseButton(on controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}
