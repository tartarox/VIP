import UIKit

protocol MainScenePresenterProtocol {
    func showCepScene()
}

final class MainScenePresenter {
    var view: MainSceneControllerProtocol?
    init(view: MainSceneControllerProtocol?) {
        self.view = view
    }
}

extension MainScenePresenter: MainScenePresenterProtocol {
    func showCepScene() {
        view?.showCepScene()
    }
}
