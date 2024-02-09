import Foundation
import UIKit
import SnapKit
import Kingfisher

class ContactTableViewCell: CustomUITableCell {
    static var identifier = "ContactTableViewCell"
    
    let avatarImage: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.setupImage(cornerRadius: 23, isHidden: true)
        return obj
    }()
    
    private let container: CustomUIStackView = {
        let obj = CustomUIStackView()
        obj.setupStackView(viewSpacing: 5, viewDistribution: .fillEqually, viewContentMode: .center)
        return obj
    }()
    
    private let nameLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        return obj
    }()
    
    private let phoneNumberLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        obj.setupLabel(fontName: Constants.Fonts.secondaryFont, fontSize: 14, fontColor: UIColor(named: Constants.Colors.forSecondary))
        return obj
    }()
    
    private let arrowImageView: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.image = UIImage(systemName: "chevron.forward")?.withTintColor(UIColor(named: Constants.Colors.forMainElements) ?? .systemGray, renderingMode: .alwaysOriginal)
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
        contentView.addSubview(container)
        contentView.addSubview(arrowImageView)
        
        container.addArrangedSubview(nameLabel)
        container.addArrangedSubview(phoneNumberLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        container.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(22)
            make.top.bottom.equalTo(contentView).inset(10)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView)
        }
    }
    
    func constraintsUpdate() {
        if !avatarImage.isHidden {
            avatarImage.snp.makeConstraints { make in
                make.top.bottom.equalTo(contentView).inset(10)
                make.size.equalTo(46)
            }
            
            container.snp.remakeConstraints { make in
                make.leading.equalTo(avatarImage.snp.trailing).offset(8)
                make.centerY.equalTo(avatarImage.snp.centerY)
            }
            
        } else {
            avatarImage.snp.removeConstraints()
            
            container.snp.remakeConstraints { make in
                make.leading.trailing.equalTo(contentView).inset(22)
                make.top.bottom.equalTo(contentView).inset(10)
            }
        }
        
    }
}

// MARK: - adding data to items
extension ContactTableViewCell {
    func handle(with data: ContactInfo) {
        nameLabel.text = data.firstName + " " + data.lastName
        phoneNumberLabel.text = data.phoneNumber
    }
    
    func handleAvatar(with data: UserDetail) {
        avatarImage.kf.setImage(with: data.avatarUrl)
    }
}
