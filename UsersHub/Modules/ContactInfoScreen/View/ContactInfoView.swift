import Foundation
import UIKit
import SnapKit
import Kingfisher

class ContactInfoView: UIView {
    private var isFlipped = true
    
    let scrollView: CustomScrollView = {
        let obj = CustomScrollView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let generalStackView: CustomUIStackView = {
        let obj  = CustomUIStackView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.spacing = 50
        return obj
    }()
    
    let labelsStackView: CustomUIStackView = {
        let obj  = CustomUIStackView()
        obj.alignment = .center
        obj.setupStackView(viewSpacing: 5, viewDistribution: .fillProportionally, viewContentMode: .center)
        return obj
    }()
    
    let containerView: CustomUIView = {
        let obj = CustomUIView()
        obj.setupView(hidden: true)
        return obj
    }()
    
    let gitHubLabel: CustomUILabel = {
        let obj  = CustomUILabel()
        obj.setupLabel(alignment: .center, labelText: "GitHub")
        return obj
    }()
    
    let loadingIndicator: CustomActivityIndicator = {
        let obj = CustomActivityIndicator(frame: .zero)
        return obj
    }()
    
    let name: CustomUILabel = {
        let obj  = CustomUILabel()
        return obj
    }()
    
    let email: CustomUILabel = {
        let obj  = CustomUILabel()
        return obj
    }()
    
    let phoneNumber: CustomUILabel = {
        let obj  = CustomUILabel()
        return obj
    }()
    
    let gender: CustomUILabel = {
        let obj  = CustomUILabel()
        return obj
    }()
    
    let age: CustomUILabel = {
        let obj  = CustomUILabel()
        return obj
    }()
    
    let birthDate: CustomUILabel = {
        let obj  = CustomUILabel()
        return obj
    }()
    
    
    let addButton: CustomUIButton = {
        let obj  = CustomUIButton()
        obj.setup(title: "Add GitHub")
        return obj
    }()
    
    let removeButton: CustomUIButton = {
        let obj  = CustomUIButton()
        obj.setup(title: "Remove")
        obj.isHidden = true
        return obj
    }()
    
    let separatorView: CustomUIView = {
        let obj = CustomUIView()
        obj.setupView(backColor: UIColor(named: Constants.Colors.forSeparator))
        return obj
    }()
    
    let viewForImages: CustomUIView = {
        let obj = CustomUIView()
        return obj
    }()
    
    let avatarImageView: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.setupImage(cornerRadius: 70)
        return obj
    }()
    
    private let userQrCodeImage: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.setupImage(isHidden: true)
        return obj
    }()
    
    let loginLabel: CustomUILabel = {
        let obj  = CustomUILabel()
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
        addSubview(scrollView)
        addSubview(loadingIndicator)
        
        scrollView.addSubview(generalStackView)
        
        generalStackView.addArrangedSubview(labelsStackView)
        generalStackView.addArrangedSubview(separatorView)
        generalStackView.addArrangedSubview(containerView)
        generalStackView.addArrangedSubview(addButton)
        
        labelsStackView.addArrangedSubview(name)
        labelsStackView.addArrangedSubview(email)
        labelsStackView.addArrangedSubview(phoneNumber)
        labelsStackView.addArrangedSubview(gender)
        labelsStackView.addArrangedSubview(birthDate)
        labelsStackView.addArrangedSubview(age)
        
        containerView.addSubview(gitHubLabel)
        containerView.addSubview(viewForImages)
        containerView.addSubview(loginLabel)
        containerView.addSubview(removeButton)
        
        viewForImages.addSubview(avatarImageView)
        viewForImages.addSubview(userQrCodeImage)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(22)
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        generalStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelsStackView.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(50)
            make.bottom.equalTo(removeButton.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        gitHubLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        viewForImages.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(240)
            make.top.equalTo(gitHubLabel.snp.bottom).offset(30)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        userQrCodeImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
    }
}

//MARK: - adding data to items
extension ContactInfoView {
    func handle(data: ContactInfo) {
        email.text = "Email: \(data.email)"
        phoneNumber.text = "Phone number: \(data.phoneNumber)"
        gender.text = "Gender: \(data.gender)"
        birthDate.text = "Birth date: \(data.birthDate)"
        age.text = "Age: \(data.age)"
    }
    
    func handleGitHub(with data: UserDetail) {
        avatarImageView.kf.setImage(with: data.avatarUrl)
        userQrCodeImage.image = HelperFunctions.didGenerateQrCode(url: data.htmlUrl)
        loginLabel.text = data.login
    }
}

//MARK: - animate click on the button
extension ContactInfoView {
    func animateButton(btnName: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            btnName.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                btnName.transform = CGAffineTransform.identity
            }
        }
    }
}

//MARK: - make flipping animation
extension ContactInfoView {
    func animateImagesTransition() {
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
