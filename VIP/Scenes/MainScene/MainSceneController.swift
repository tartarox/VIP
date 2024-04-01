import UIKit

protocol MainSceneControllerProtocol: AnyObject {
    func showCepScene()
}

final class MainSceneController: UIViewController {
    var interactor: MainSceneInteractorProtocol?
    
    private lazy var cepButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(
            title: "Search CEP",
            handler: {[weak self] _ in
                guard let self = self else { return }
                self.interactor?.showNextView()
            }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(cepButton)
        configureLayout()
    }
    
    private func configureLayout() {
        self.view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            cepButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            cepButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            cepButton.widthAnchor.constraint(equalToConstant: 300),
            cepButton.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension MainSceneController: MainSceneControllerProtocol {
    func showCepScene() {
        let controller = UserSceneConfigurator.build()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
