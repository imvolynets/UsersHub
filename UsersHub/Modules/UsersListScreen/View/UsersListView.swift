import Foundation
import UIKit
import SnapKit

class UsersListView: UIView {
    let searchController: CustomUISearchController = {
        let obj = CustomUISearchController(searchResultsController: nil )
        return obj
    }()
    
    let tableView: CustomUITableView = {
        let obj = CustomUITableView()
        return obj
    }()
    
    let refreshControl: UIRefreshControl = {
        let obj = UIRefreshControl()
        obj.tintColor = UIColor(named: Constants.Colors.forMainElements)
        return obj
    }()
    
    let loadingIndicator: CustomActivityIndicator = {
        let obj = CustomActivityIndicator(frame: .zero)
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: Constants.Colors.forBackground)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(tableView)
        addSubview(loadingIndicator)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(22)
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}


