struct MainSceneConfigurator {
    static func build() -> MainSceneController {
        let view = MainSceneController()
        let presenter = MainScenePresenter(view: view)
        let interactor = MainSceneInteractor(presenter: presenter)
        view.interactor = interactor
        
        return view
    }
}
