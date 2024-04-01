import UIKit

protocol MainSceneInteractorProtocol {
    func showNextView()
}

final class MainSceneInteractor {
    var presenter: MainScenePresenterProtocol?
    init(presenter: MainScenePresenterProtocol?) {
        self.presenter = presenter
    }
}

extension MainSceneInteractor: MainSceneInteractorProtocol {
    func showNextView() {
        presenter?.showCepScene()
    }
}
