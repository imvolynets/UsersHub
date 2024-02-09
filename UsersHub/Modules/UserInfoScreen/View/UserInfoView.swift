import Foundation
import UIKit
import SnapKit

class UserInfoView: UIView {
    private var isFlipped = true
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        obj.backgroundColor = .clear
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.showsHorizontalScrollIndicator = false
        obj.isHidden = true
        return obj
    }()
    
    private let generalStackView: CustomUIStackView = {
        let obj = CustomUIStackView()
        return obj
    }()
    
    private let labelsStackView: CustomUIStackView = {
        let obj = CustomUIStackView()
        obj.setupStackView(viewSpacing: 4, viewDistribution: .fillProportionally, viewContentMode: .center)
        return obj
    }()
    
    private let containerView: CustomUIView = {
        let obj = CustomUIView()
        return obj
    }()
    
    let viewForImages: CustomUIView = {
        let obj = CustomUIView()
        return obj
    }()
    
    let separatorView: CustomUIView = {
        let obj = CustomUIView()
        obj.setupView(backColor: UIColor(named: Constants.Colors.forSeparator), hidden: true)
        return obj
    }()
    
    private let avatarImageView: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.setupImage(cornerRadius: 70)
        return obj
    }()
    
    private let userQrCodeImage: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.setupImage(isHidden: true)
        return obj
    }()
    
    private let userNameLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        return obj
    }()
    
    private let userCompanyLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        return obj
    }()
    
    private let userBlogLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        return obj
    }()
    
    private let userLocationLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        return obj
    }()
    
    let FollowersLabel: CustomUILabel = {
        let obj =  CustomUILabel()
        obj.setupLabel(hidden: true, alignment: .center, labelText: "Followers")
        return obj
    }()
    
    let loadingIndicator: CustomActivityIndicator = {
        let obj = CustomActivityIndicator(frame: .zero)
        return obj
    }()
    
    let viewForIndicator: CustomUIView = {
        let obj = CustomUIView()
        return obj
    }()
    
    let loadingIndicatorFollowers: CustomActivityIndicator = {
        let obj = CustomActivityIndicator(frame: .zero)
        return obj
    }()
    
    private let scrollView: CustomScrollView = {
        let obj = CustomScrollView()
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.27, green: 0.24, blue: 0.25, alpha: 1.00)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(scrollView)
        addSubview(loadingIndicator)
        
        scrollView.addSubview(generalStackView)
        generalStackView.addArrangedSubview(containerView)
        
        generalStackView.addArrangedSubview(FollowersLabel)
        generalStackView.addArrangedSubview(viewForIndicator)
        generalStackView.addArrangedSubview(collectionView)
        
        containerView.addSubview(viewForImages)
        containerView.addSubview(labelsStackView)
        containerView.addSubview(separatorView)
        
        labelsStackView.addArrangedSubview(userNameLabel)
        labelsStackView.addArrangedSubview(userCompanyLabel)
        labelsStackView.addArrangedSubview(userBlogLabel)
        labelsStackView.addArrangedSubview(userLocationLabel)
        
        viewForIndicator.addSubview(loadingIndicatorFollowers)
        
        viewForImages.addSubview(userQrCodeImage)
        viewForImages.addSubview(avatarImageView)
        
        makeConstraints()
        constraintsUpdate()
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(22)
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        generalStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.centerX.equalTo(scrollView.snp.centerX)
            make.bottom.equalToSuperview().offset(-10)
        }
        containerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(self.separatorView.snp.bottom)
        }
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(viewForImages.snp.bottom).offset(30)
            make.width.equalTo(280)
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        viewForImages.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(240)
            make.top.equalToSuperview()
        }
        avatarImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        userQrCodeImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        viewForIndicator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(226)
        }
        loadingIndicatorFollowers.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func constraintsUpdate() {
        let isLandscape = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
        
        if isLandscape {
            containerView.snp.remakeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
                make.bottom.equalTo(self.separatorView.snp.bottom)
            }
            viewForImages.snp.remakeConstraints { make in
                make.leading.equalToSuperview()
                make.centerY.equalToSuperview()
                make.size.equalTo(240)
            }
            labelsStackView.snp.remakeConstraints { make in
                make.leading.equalTo(viewForImages.snp.trailing).offset(30)
                make.centerY.equalToSuperview()
                make.width.equalTo(280)
            }
            separatorView.snp.remakeConstraints { make in
                make.top.equalTo(viewForImages.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(1) // Adjust the height of the separator as needed
                
            }
            viewForIndicator.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(226)
            }
            loadingIndicatorFollowers.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
        } else {
            viewForImages.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.size.equalTo(240)
                make.top.equalToSuperview()
            }
            containerView.snp.remakeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
                make.bottom.equalTo(self.labelsStackView.snp.bottom).offset(12)
            }
            labelsStackView.snp.remakeConstraints { make in
                make.top.equalTo(viewForImages.snp.bottom).offset(28)
                make.width.equalTo(280)
            }
            separatorView.snp.remakeConstraints { make in
                make.top.equalTo(labelsStackView.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(1)
            }
            
        }
    }
}

// MARK: - adding data to items
extension UserInfoView {
    func handle(with data: UserDetail) {
        if let dataName = data.name {
            userNameLabel.text = "Name: \(dataName)"
        }
        
        if let dataCompany = data.company {
            userCompanyLabel.text = "Company:  \(dataCompany)"
        }
        
        if let dataBlog = data.blog, dataBlog != "" {
            userBlogLabel.text = "Blog: \(dataBlog)"
        }
        
        if let dataLocation = data.location {
            userLocationLabel.text = "Location: \(dataLocation)"
        }
        
        avatarImageView.kf.setImage(with:data.avatarUrl)
        userQrCodeImage.image = HelperFunctions.didGenerateQrCode(url: data.htmlUrl)
    }
}

//MARK: - make flipping animation
extension UserInfoView {
    func animateFlipTransition() {
        if isFlipped {
            UIView.transition(with: viewForImages, duration: 0.5, options: .transitionFlipFromRight, animations: { [self] in
                avatarImageView.isHidden = true
                userQrCodeImage.isHidden = false
                
                isFlipped.toggle()
            }, completion: nil)
            
            
        } else {
            UIView.transition(with: viewForImages, duration: 0.5, options: .transitionFlipFromLeft, animations: { [self] in
                avatarImageView.isHidden = false
                userQrCodeImage.isHidden = true
                
                isFlipped.toggle()
            }, completion: nil)
        }
    }
}
