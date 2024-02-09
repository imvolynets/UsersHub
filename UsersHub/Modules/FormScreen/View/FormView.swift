import Foundation
import UIKit
import SnapKit

class FormView: UIView {
    private let generalStackView: CustomUIStackView = {
        let obj = CustomUIStackView()
        obj.setupStackView(viewSpacing: 20, viewDistribution: .fillEqually)
        return obj
    }()
    
    private let containerForMainInfo: CustomUIStackView = {
        let obj = CustomUIStackView()
        obj.setupStackView(viewAxis: .horizontal, viewSpacing: 20, viewDistribution: .fillEqually)
        return obj
    }()
    
    private let containerForBirthDate: CustomUIStackView = {
        let obj = CustomUIStackView()
        obj.setupStackView(viewAxis: .horizontal, viewSpacing: 20)
        return obj
    }()
    
    let personFirstName: CustomUITextField = {
        let obj = CustomUITextField()
        obj.placeholder = "Enter first name..."
        return obj
    }()
    
    let personLastName: CustomUITextField = {
        let obj = CustomUITextField()
        obj.placeholder = "Enter last name..."
        return obj
    }()
    
    let personEmail: CustomUITextField = {
        let obj = CustomUITextField()
        obj.placeholder = "Enter email..."
        
        return obj
    }()
    
    let personPhoneNumber: CustomUITextField = {
        let obj = CustomUITextField()
        obj.placeholder = "Enter phone number..."
        
        return obj
    }()
    
    let segmentControlForGenders: UISegmentedControl = {
        let obj = UISegmentedControl(items: ["Male", "Female", "Other"])
        obj.backgroundColor = UIColor(named: Constants.Colors.forMainElements)
        obj.selectedSegmentIndex = 0
        obj.selectedSegmentTintColor = UIColor(named: Constants.Colors.forModalBackground)
        return obj
    }()
    
    let birthLabel: CustomUILabel = {
        let obj = CustomUILabel()
        obj.setupLabel(labelText: "Select your birth date")
        return obj
    }()
    
    let titleLabel: CustomUILabel = {
        let obj = CustomUILabel()
        obj.setupLabel(fontSize: 20 ,alignment: .center, labelText: "User Form")
        return obj
    }()
    
    let datePickerForBirthDate: UIDatePicker = {
        let obj = UIDatePicker()
        obj.datePickerMode = .date
        obj.preferredDatePickerStyle = .compact
        return obj
    }()
    
    let saveButton: CustomUIButton = {
        let obj  = CustomUIButton()
        obj.setup(title: "Save")
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
        addSubview(generalStackView)
        
        generalStackView.addArrangedSubview(containerForMainInfo)
        generalStackView.addArrangedSubview(personEmail)
        generalStackView.addArrangedSubview(personPhoneNumber)
        generalStackView.addArrangedSubview(segmentControlForGenders)
        generalStackView.addArrangedSubview(containerForBirthDate)
        
        containerForMainInfo.addArrangedSubview(personFirstName)
        containerForMainInfo.addArrangedSubview(personLastName)
        
        containerForBirthDate.addArrangedSubview(birthLabel)
        containerForBirthDate.addArrangedSubview(datePickerForBirthDate)
        
        addSubview(saveButton)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(22)
        }
        
        generalStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview().inset(22)
            make.bottom.equalTo(containerForBirthDate.snp.bottom)
        }
        
        personFirstName.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(generalStackView.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
    }
}

//MARK: animate click on the button
extension FormView {
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
