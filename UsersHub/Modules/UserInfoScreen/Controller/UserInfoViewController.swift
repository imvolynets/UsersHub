import Foundation
import UIKit

class UserInfoViewController: UIViewController {
    private let mainView = UserInfoView()
    private var apiResult = [UserFollowers]()
    var userLogin = String()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        mainView.constraintsUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.constraintsUpdate()
    }
    
    private func initViewController() {
        setNavBarStyle()
        initCollectionView()
        initGestureRecognizer()
        loadUserDetail()
    }
}

//MARK: - init items
extension UserInfoViewController {
    private func initCollectionView() {
        mainView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
    
    private func initGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipImage))
        mainView.viewForImages.addGestureRecognizer(tapGestureRecognizer)
    }
}

//MARK: - api
extension UserInfoViewController {
    private func loadUserDetail() {
        mainView.loadingIndicator.startAnimating()
        
        APIManager.sharedInstance.fetchingUserDetail(userLogin: userLogin){ result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let data):
                    loadUserFollowersImages()
                    mainView.handle(with: data)
                    mainView.loadingIndicator.stopAnimating()
                    mainView.separatorView.isHidden = false
                    
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
            
        }
    }
    
    private func loadUserFollowersImages() {
        mainView.loadingIndicatorFollowers.startAnimating()
        
        APIManager.sharedInstance.fetchingUserFollowersImage(userLogin: userLogin){ result in
            self.apiResult = result
            DispatchQueue.main.async { [self] in
                mainView.collectionView.reloadData()
                mainView.loadingIndicatorFollowers.stopAnimating()
                mainView.viewForIndicator.isHidden = true
                mainView.collectionView.isHidden = false
                mainView.FollowersLabel.isHidden = false
            }
        }
    }
}

// MARK: - collectionView
extension UserInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:   CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let rowData = apiResult[indexPath.row]
        cell.handle(with: rowData)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openUserInfoViewController(for: indexPath)
    }
}

// MARK: - navigation
extension UserInfoViewController {
    private func openUserInfoViewController(for indexPath: IndexPath) {
        let userInfoViewController = UserInfoViewController()
        userInfoViewController.userLogin = apiResult[indexPath.row].login
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
    }
}

//MARK: - actions
extension UserInfoViewController {
    @objc 
    func flipImage() {
        mainView.animateFlipTransition()
    }
    
    @objc 
    private func didTapButton() {
        openUserGitHub()
    }
}

//MARK: - open user github
extension UserInfoViewController {
    private func openUserGitHub() {
        if let url = URL(string: "http://github.com/\(userLogin)") {
            UIApplication.shared.open(url)
        }
    }
}

//MARK: - setting navigation style
extension UserInfoViewController {
    private func setNavBarStyle() {
        self.navigationItem.title = userLogin
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont(name: Constants.Fonts.mainFont, size: 16) ?? .systemFont(ofSize: 16), .foregroundColor: UIColor(named: Constants.Colors.forMainElements) ?? .systemGray]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor(named: Constants.Colors.forMainElements)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "link"), style: .plain, target: self, action: #selector(didTapButton))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: Constants.Colors.forMainElements)
    }
}



