import Foundation
import UIKit

class LoadingCell: CustomUITableCell {
    static let identifier = "LoadingTableCell"
    
    let loadingIndicator: CustomActivityIndicator = {
        let obj = CustomActivityIndicator(frame: .zero)
        obj.setupIndicator(indicatorStyle: .medium)
        return obj
    }()
    
    override init(style: CustomUITableCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(loadingIndicator)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
}
