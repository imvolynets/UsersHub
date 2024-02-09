import UIKit
import SnapKit

class UsersListViewController: UIViewController {
    private let mainView = UsersListView()
    private var apiResult = [User]()
    private var filteredData = [User]()
    private var isFirstLoading = true
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectRow(animated: animated)
    }
    
    private func initViewController() {
        setNavBarStyle()
        initTableView()
        initRefreshControl()
        initSearchController()
        fetchUsers()
    }
}

//MARK: - init items
extension UsersListViewController {
    private func initTableView() {
        mainView.tableView.register(UsersListTableCell.self, forCellReuseIdentifier: UsersListTableCell.identifier)
        mainView.tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    private func initRefreshControl() {
        mainView.refreshControl.addTarget(self, action: #selector(handleRefreshControll), for: .valueChanged)
        mainView.tableView.refreshControl =  mainView.refreshControl
    }
    
    private func initSearchController() {
        mainView.searchController.searchResultsUpdater = self
    }
}


//MARK: - api
extension UsersListViewController {
    private func fetchUsers(refresh: Bool = false) {
        if isFirstLoading {
            mainView.loadingIndicator.startAnimating()
        }
        
        isFirstLoading = false
        
        var id: Int? = 0
        if !refresh {
            id = apiResult.count != 0 ? apiResult.last?.id : id
        }
        
        APIManager.sharedInstance.fetchingUsers(sinceId: id){ apiData in
            if refresh {
                self.apiResult.removeAll()
                self.mainView.refreshControl.endRefreshing()
            }
            
            self.apiResult.append(contentsOf: apiData)
            
            DispatchQueue.main.async { [self] in
                mainView.loadingIndicator.stopAnimating()
                mainView.tableView.reloadData()
            }
        }
    }
}

// MARK: - tableView
extension UsersListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainView.searchController.isActive ? filteredData.count : apiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == apiResult.count - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  LoadingCell.identifier, for: indexPath) as? LoadingCell else {
                return UITableViewCell()
            }
            
            cell.loadingIndicator.startAnimating()
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  UsersListTableCell.identifier, for: indexPath) as? UsersListTableCell else {
                return UITableViewCell()
            }
            
            let rowData = mainView.searchController.isActive ? filteredData[indexPath.row] : apiResult[indexPath.row]
            cell.handle(with: rowData)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == apiResult.count - 1 {
            fetchUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openUserInfoViewController(for: indexPath)
    }
}

// MARK: - navigation
extension UsersListViewController {
    private func openUserInfoViewController(for indexPath: IndexPath) {
        let userInfoViewController = UserInfoViewController()
        userInfoViewController.userLogin = apiResult[indexPath.row].login
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    private func openQrScanner() {
        let qrScannerViewController = QrScannerViewController()
        self.navigationController?.pushViewController(qrScannerViewController, animated: true)
    }
}

//MARK: - deselect row
extension UsersListViewController {
    private func deselectRow(animated: Bool) {
        if let selectedIndexPath = mainView.tableView.indexPathForSelectedRow {
            mainView.tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
}

//MARK: - actions
extension UsersListViewController {
    @objc
    private func handleRefreshControll() {
        fetchUsers(refresh: true)
    }
    
    @objc
    private func didTapButton() {
        openQrScanner()
    }
}

//MARK: - searchBarController
extension UsersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        mainView.searchController.filterContentForSearchText(which: searchText, storeTo: &filteredData, from: apiResult)
        mainView.tableView.reloadData()
    }
}

// MARK: - setting navBar style
extension UsersListViewController {
    private func setNavBarStyle() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "qrcode.viewfinder"), style: .plain, target: self, action: #selector(didTapButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: Constants.Colors.forMainElements) ?? .systemGray
        navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

