import Foundation
import UIKit

protocol AddGitHubViewDelegate: AnyObject {
    func didUserCatched(data: UserDetail, _ resetDataFromLS: () -> Void)
}

class AddGitHubViewController: UIViewController {
    private let mainView = AddGitHubView()
    
    weak var delegate: AddGitHubViewDelegate?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    
    private func initViewController() {
        initActions()
        initTextFileds()
        loadDataFromLS()
    }
}

//MARK: - init items
extension AddGitHubViewController {
    private func initActions() {
        mainView.saveButton.addTarget(self, action: #selector(didConnectGitHub), for: .touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func initTextFileds() {
        mainView.loginTextFiled.delegate = self
        mainView.loginTextFiled.becomeFirstResponder()
    }
}

//MARK: - actions
extension AddGitHubViewController {
    @objc private func didConnectGitHub() {
        addGitToContact()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK: - checking if user's git exists by login
extension AddGitHubViewController {
    private func checkUser(userLogin: String) {
        APIManager.sharedInstance.fetchingUserDetail(userLogin: userLogin){ result in
            switch result {
            case .success(let data):
                self.delegate?.didUserCatched(data: data, self.resetDataFromLS)
            case .failure(let error):
                print(error)
                let alert = HelperFunctions.showAlert(title: "Error", message: "Invalid login")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

//MARK: - add GitHub
extension AddGitHubViewController {
    private func addGitToContact() {
        mainView.animateButton()
        
        guard let userLogin = mainView.loginTextFiled.text, !userLogin.isEmpty else {return}
        
        let isAlreadyExistLogin = DBManager.sharedInstance.valueExistsInDb(propertyForChecking: "gitHubLogin", valueToCheck: userLogin.localizedLowercase)
        if isAlreadyExistLogin {
            let alert = HelperFunctions.showAlert(title: "Invalid login", message: "This login has already existed")
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        checkUser(userLogin: userLogin)
    }
}

extension AddGitHubViewController: UITextFieldDelegate {
    
    //set textfield data to ls
    func textFieldDidEndEditing(_ textField: UITextField) {
        setDataToLS(textField)
    }
}

//MARK: - localStorage functionality
extension AddGitHubViewController {
    
    //Load data from ls
    private func loadDataFromLS() {
        mainView.loginTextFiled.text = CacheManager.sharedInstance.loadDataTo(gitHubForm: GitKey.gitHubLogin) as? String
    }
    
    //set data to ls
    private func setDataToLS(_ textField: UITextField) {
        CacheManager.sharedInstance.setDataFrom(item: mainView.loginTextFiled.text, gitHubForm: GitKey.gitHubLogin)
    }
    
    //reset data from ls
    private func resetDataFromLS() {
        
        CacheManager.sharedInstance.resetDataFrom(GitHubForm: true)
    }
    
}
