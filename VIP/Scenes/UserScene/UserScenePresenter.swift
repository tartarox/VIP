import UIKit

protocol UserScenePresenterProtocol {
    func showData(cepResponse: CepResponse)
    func showError()
}

final class UserScenePresenter {
    private weak var view: UserSceneControllerOutputProtocol?
    
    init(view: UserSceneControllerOutputProtocol) {
        self.view = view
    }
}

extension UserScenePresenter: UserScenePresenterProtocol {
    func showData(cepResponse: CepResponse) {
        DispatchQueue.main.async {
            var cells: [UITableViewCell] = []
            let mirror = Mirror(reflecting: cepResponse)
            for (_, attr) in mirror.children.enumerated() {
                if let label = attr.label, let value = attr.value as? String {
                    let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
                    cell.textLabel?.text = String(label + ": " + value)
                    cells.append(cell)
                }
            }
        
            self.view?.viewShowData(cells: cells)
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.view?.viewShowError()
        }
    }
}
