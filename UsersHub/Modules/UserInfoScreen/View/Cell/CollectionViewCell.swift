import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private let avatarImage: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.setupImage(cornerRadius: 35)
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(avatarImage)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.size.equalTo(70)
        }
    }
    
}

// MARK: - adding data to items
extension CollectionViewCell {
    func handle(with data: UserFollowers) {
        avatarImage.kf.setImage(with: data.avatarUrl)
    }
}

