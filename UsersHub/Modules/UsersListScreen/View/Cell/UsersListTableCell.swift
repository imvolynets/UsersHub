import Foundation
import UIKit
import SnapKit
import Kingfisher

class UsersListTableCell: CustomUITableCell {
    static var identifier = "UsersListTableCell"
    
    private let loginLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        return obj
    }()
    
    private let urlLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        obj.setupLabel(fontName: Constants.Fonts.secondaryFont, fontSize: 14, fontColor: UIColor(named: Constants.Colors.forSecondary))
        return obj
    }()
    
    private let avatarImage: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.setupImage(cornerRadius: 23)
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
        contentView.addSubview(avatarImage)
        contentView.addSubview(loginLabel)
        contentView.addSubview(urlLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(17)
            make.size.equalTo(46)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImage.snp.trailing).offset(8)
            make.top.equalTo(contentView).offset(8)
        }
        
        urlLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImage.snp.trailing).offset(8)
            make.top.equalTo(loginLabel.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).offset(-27)
        }
    }
}

// MARK: - adding data to items
extension UsersListTableCell {
    func handle(with data: User) {
        loginLabel.text = data.login
        urlLabel.text = data.url
        avatarImage.kf.setImage(with: data.avatarUrl)
    }
}
