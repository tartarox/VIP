struct UserSceneConfigurator {
    static func build() -> UserSceneController {
        let view = UserSceneController()
        let presenter = UserScenePresenter(view: view)
        let interactor = UserSceneInteractor(presenter: presenter)
        interactor.setWorker(worker: UserWorker())
        view.interactor = interactor
        return view
    }
}
