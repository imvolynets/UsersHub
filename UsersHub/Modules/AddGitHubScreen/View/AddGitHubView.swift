import Foundation
import UIKit
import SnapKit

class AddGitHubView: UIView {
    private let titleLabel: CustomUILabel = {
        let obj = CustomUILabel()
        obj.setupLabel(fontSize: 20 ,alignment: .center, labelText: "GitHub Form")
        return obj
    }()
    
    private let logoGitHubImageView: CustomImageView = {
        let obj = CustomImageView(frame: .zero)
        obj.image = UIImage(named: "logoGit")
        return obj
    }()
    
    private let loginInLabel: CustomUILabel = {
        let obj  = CustomUILabel()
        obj.setupLabel(fontSize: 18, alignment: .center,labelText: "Enter your login")
        return obj
    }()
    
    let loginTextFiled: CustomUITextField = {
        let obj = CustomUITextField()
        obj.placeholder = "volyn..."
        return obj
    }()
    
    let saveButton: CustomUIButton = {
        let obj  = CustomUIButton()
        obj.setup(title: "Add")
        obj.backgroundColor = UIColor(named: Constants.Colors.forButtonBackground)
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: Constants.Colors.forModalBackground)
        

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(logoGitHubImageView)
        addSubview(loginInLabel)
        addSubview(loginTextFiled)
        addSubview(saveButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(22)
        }
        logoGitHubImageView.snp.makeConstraints { make in
            make.size.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
        }
        loginInLabel.snp.makeConstraints { make in
            make.top.equalTo(logoGitHubImageView.snp.bottom).offset(42)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        loginTextFiled.snp.makeConstraints { make in
            make.top.equalTo(loginInLabel.snp.bottom).offset(22)
            make.width.equalTo(250)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(loginTextFiled.snp.bottom).offset(22)
            make.width.equalTo(180)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
    }
}

//MARK: animate click on the button
extension AddGitHubView {
    func animateButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.saveButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                self.saveButton.transform = CGAffineTransform.identity
            }
        }
    }
}
