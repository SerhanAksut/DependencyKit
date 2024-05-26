
import FeatureInterface
import FeatureStore
import UIKit

final class SecondFeatureViewController: UIViewController {
    
    private weak var delegate: SecondFeatureCloseButtonDelegate?
    
    init(delegate: SecondFeatureCloseButtonDelegate) {
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .green
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.backgroundColor = . white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Close Second Feature", for: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    @objc func didTapCloseButton() {
        delegate?.didTapCloseButton(on: self)
    }
}
