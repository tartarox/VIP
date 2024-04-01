import UIKit

protocol UserSceneControllerOutputProtocol: AnyObject {
    func viewShowData(cells: [UITableViewCell])
    func viewShowError()
}

final class UserSceneController: UIViewController {
    var interactor: UserSceneInteractor?
    var cells: [UITableViewCell]?
    
    private lazy var button: UIButton = {
        let button = UIButton(
            type: .system,
            primaryAction: UIAction(
                title: "Search CEP",
                handler: {[weak self] _ in
                    guard let self = self, let text = self.textField.text else { return }
                    self.interactor?.getUserData(cep: text)
        }))
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(button)
        self.view.addSubview(textField)
        self.view.addSubview(tableView)
        self.ajustConstraints()
    }

    private func ajustConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            button.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UserSceneController: UserSceneControllerOutputProtocol {
    func viewShowData(cells: [UITableViewCell]) {
        self.cells = cells
        self.tableView.reloadData()
    }
    
    func viewShowError() {
        let alert = UIAlertController(title: "Erro", message: "Insira um Cep Válido", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension UserSceneController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cells?[indexPath.row] ?? UITableViewCell()
    }
}
