import Foundation
import UIKit
import SnapKit

class ContactsListView: UIView {
    let tableView: CustomUITableView = {
        let obj = CustomUITableView()
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
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(22)
        }
    }
    
}

