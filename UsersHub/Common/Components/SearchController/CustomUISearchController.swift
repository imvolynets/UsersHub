import Foundation
import UIKit
import RealmSwift

class CustomUISearchController: UISearchController {
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController:  nil)
        initViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViewController() {
        setupSearchController()
    }
}

//MARK: - Setting Search Controller
extension CustomUISearchController {
    private func setupSearchController() {
        obscuresBackgroundDuringPresentation = false
        hidesNavigationBarDuringPresentation = false
        definesPresentationContext = false
        
        searchBar.placeholder = "Search..."
        searchBar.tintColor = UIColor(named: Constants.Colors.forSecondary)
    }
}

//MARK: - Filtering
extension CustomUISearchController {
    func filterContentForSearchText(which searchText: String, storeTo filteredData: inout [User], from allData: [User]) {
        filteredData = allData.filter {$0.login.contains(searchText.localizedLowercase)}
    }
}
