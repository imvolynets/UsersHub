import Foundation
import UIKit
import RealmSwift

class ContactInfoViewContoller: UIViewController {
    var personInfo = ContactInfo()
    private let mainView = ContactInfoView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()

    }
    
    private func initViewController() {
        setNavBarStyle()
        initButtons()
        initGestureRecognizer()
        loadData()
    }
}

//MARK: - init items
extension ContactInfoViewContoller {
    private func initButtons() {
        mainView.addButton.addTarget(self, action: #selector(addGitHub), for: .touchUpInside)
        mainView.removeButton.addTarget(self, action: #selector(removeGit), for: .touchUpInside)
        
        if personInfo.gitHubLogin != "" {
            mainView.addButton.isHidden = true
            mainView.removeButton.isHidden = true
            loadUserDetail()
        } else {
            
            mainView.addButton.isHidden = false
            mainView.removeButton.isHidden = true
        }
    }
    private func initGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipImage))
        mainView.viewForImages.addGestureRecognizer(tapGestureRecognizer)
    }
}

//MARK: - load data from db
extension ContactInfoViewContoller {
    private func loadData() {
        mainView.handle(data: personInfo)
    }
}

//MARK: - api
extension ContactInfoViewContoller {
    private func loadUserDetail() {
        mainView.addButton.isHidden = true
        mainView.loadingIndicator.startAnimating()
        APIManager.sharedInstance.fetchingUserDetail(userLogin: personInfo.gitHubLogin){ result in
            
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let data):
                    mainView.handleGitHub(with: data)
                    mainView.removeButton.isHidden = false
                    mainView.containerView.isHidden = false
                    mainView.loadingIndicator.stopAnimating()
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    
                }
            }
            
        }
    }
    
}

//MARK: - actions
extension ContactInfoViewContoller {
    
    @objc
    private func addGitHub() {
        openAddGitHubViewController()
    }
    
    @objc 
    private func removeGit() {
        mainView.animateButton(btnName: mainView.removeButton)
        
        DBManager.sharedInstance.removeGitHub(id: personInfo.id)
        
        mainView.addButton.isHidden = false
        mainView.removeButton.isHidden = true
        
        mainView.containerView.isHidden = true
        
        let alert = HelperFunctions.showAlert(title: "Successfuly", message: "You successfuly removed account")
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func flipImage() {
        mainView.animateImagesTransition()
    }
}

//MARK: - navigation
extension ContactInfoViewContoller {
    private func openAddGitHubViewController() {
        mainView.animateButton(btnName: mainView.addButton)
        
        let addGitHubViewController = AddGitHubViewController()
        addGitHubViewController.delegate = self
        
        if let sheet = addGitHubViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 20
        }
        
        present(addGitHubViewController, animated: true)
    }
}

//MARK: - Setting navBar style
extension ContactInfoViewContoller {
    private func setNavBarStyle() {
        self.navigationItem.title = personInfo.firstName + " " + personInfo.lastName
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont(name: Constants.Fonts.mainFont, size: 16) ?? .systemFont(ofSize: 16), .foregroundColor: UIColor(named: Constants.Colors.forMainElements) ?? .gray]
    }
}

//MARK: - AddGitHubViewDelegate
extension ContactInfoViewContoller: AddGitHubViewDelegate {
    func didValueChanged(value: String) {
        return
    }
    
    
    func didUserCatched(data: UserDetail, _ resetDataFromLS: () -> Void) {
        DBManager.sharedInstance.addGitHub(id: personInfo.id, gitLogin: data.login)
        dismiss(animated: true)
        resetDataFromLS()
        loadUserDetail()
    }
}
