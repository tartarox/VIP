protocol UserSceneInteractorProcol {
    func getUserData(cep: String)
}

final class UserSceneInteractor {
    private var presenter: UserScenePresenterProtocol?
    private var worker: UserWorker?
    
    init(presenter: UserScenePresenterProtocol) {
        self.presenter = presenter
    }
    
    func setWorker(worker: UserWorker) {
        self.worker = worker
    }
}

extension UserSceneInteractor: UserSceneInteractorProcol {
    func getUserData(cep: String) {
        self.worker?.getCep(cep: cep, completion: {[weak self] response in
            guard let self = self else { return }
            switch response {
            case .some(let cep):
                self.presenter?.showData(cepResponse: cep)
            case .none:
                self.presenter?.showError()
            }
        })
    }
}
