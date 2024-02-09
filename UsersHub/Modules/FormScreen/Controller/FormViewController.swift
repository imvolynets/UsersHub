import Foundation
import UIKit

// LC - Local Storage

//MARK: - FormViewControllerDelegate
protocol FormViewControllerDelegate: AnyObject {
    func didContantCreated()
}

class FormViewController: UIViewController {
    private let mainView = FormView()
    weak var delegate: FormViewControllerDelegate?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    
    private func initViewController() {
        initActions()
        initTextFileds()
        loadDataFromLS()
    }
}

//MARK: - init items
extension FormViewController {
    private func initActions() {
        mainView.saveButton.addTarget(self, action: #selector(didAddPerson), for: .touchUpInside)
        mainView.segmentControlForGenders.addTarget(self, action: #selector(handleSegemntControl), for: .valueChanged)
        mainView.datePickerForBirthDate.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func initTextFileds() {
        mainView.personEmail.keyboardType = .emailAddress
        mainView.personPhoneNumber.keyboardType = .numberPad
        
        mainView.personFirstName.delegate = self
        mainView.personLastName.delegate = self
        mainView.personEmail.delegate = self
        mainView.personPhoneNumber.delegate = self
        
        mainView.personFirstName.becomeFirstResponder()
    }
}

//MARK: - actions
extension FormViewController {
    @objc
    private func didAddPerson() {
        addPerson()
    }
    
    @objc
    private func handleSegemntControl() {
        setSegmentIndexToLS()
    }
    
    @objc
    private func handleDatePicker() {
        setDateToLS()
    }
    
    @objc
    private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK: - adding person
extension FormViewController {
    private func addPerson() {
        mainView.animateButton()
        
        guard let firstName = mainView.personFirstName.text , !firstName.isEmpty, Validation.isValidName(mainView.personFirstName.text) else {return}
        guard let lastName = mainView.personLastName.text , !lastName.isEmpty, Validation.isValidName(mainView.personLastName.text) else {return}
        guard let userEmail = mainView.personEmail.text, !userEmail.isEmpty,  Validation.isValidEmail(mainView.personEmail.text) else { return }
        guard let userPhone = mainView.personPhoneNumber.text, !userPhone.isEmpty,  Validation.isValidPhoneNumber(mainView.personPhoneNumber.text) else { return }
        guard let userGender = mainView.segmentControlForGenders.titleForSegment(at: mainView.segmentControlForGenders.selectedSegmentIndex) else {return}
        let userBirthDate = Validation.isValidAge(birthDate: mainView.datePickerForBirthDate.date) ? mainView.datePickerForBirthDate.date : nil
        
        if userBirthDate == nil {
            let alert = HelperFunctions.showAlert(title: "Invalid birth date", message: "Make sure you are older than 16 years old and younger than 75 years old")
            
            mainView.personPhoneNumber.resignFirstResponder()
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let isAlreadyExistPhoneNumber = DBManager.sharedInstance.valueExistsInDb(propertyForChecking: "phoneNumber", valueToCheck: userPhone)
        if isAlreadyExistPhoneNumber {
            let alert = HelperFunctions.showAlert(title: "Invalid phone number", message: "This phone number has already existed")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        saveContact(firstName: firstName, lastName: lastName, userEmail: userEmail, userPhone: userPhone, userGender: userGender, userBirthDate: userBirthDate!)
    }
}

//MARK: - save contact
extension FormViewController {
    private func saveContact(firstName: String, lastName: String, userEmail: String, userPhone: String, userGender: String, userBirthDate: Date) {
        let user = ContactInfo()
        user.firstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        user.lastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        user.phoneNumber = userPhone
        user.email = userEmail.trimmingCharacters(in: .whitespacesAndNewlines)
        user.gender = userGender
        user.birthDate = Formatting.formatterDateString(date: userBirthDate)
        user.age = HelperFunctions.didCalcAge(from: userBirthDate)
        
        DBManager.sharedInstance.saveContact(contact: user)
        
        delegate?.didContantCreated()
        
        dismiss(animated: true, completion: nil)
        resetDataFromLS()
    }
}

//MARK: - form functionality
extension FormViewController: UITextFieldDelegate {
    
    // handle return key pressed for textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mainView.personFirstName {
            mainView.personLastName.becomeFirstResponder()
            
        } else if textField == mainView.personLastName {
            mainView.personEmail.becomeFirstResponder()
        } else if textField == mainView.personEmail {
            mainView.personPhoneNumber.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    // limit characters for text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mainView.personFirstName || textField == mainView.personLastName {
            if range.location <= Constants.UserForm.maxChName {
                return true
            }
            return false
        }
        
        if textField == mainView.personEmail {
            if range.location <= Constants.UserForm.maxChEmail {
                return true
            }
            return false
        }
        
        if textField == mainView.personPhoneNumber {
            guard let phoneNumberText = mainView.personPhoneNumber.text else {return false}
            let newString = (phoneNumberText as NSString).replacingCharacters(in: range, with: string)
            mainView.personPhoneNumber.text = Formatting.formatterPhoneNumber(mask: Constants.UserForm.phoneMask, phoneNumber: newString)
            return false
        }
        
        return true
    }
    
    //set textfields' data to ls
    func textFieldDidEndEditing(_ textField: UITextField) {
        setDataToLS(textField)
    }
}

//MARK: - localStorage functionality
extension FormViewController {
    
    //Load data from ls
    private func loadDataFromLS() {
        mainView.personFirstName.text = CacheManager.sharedInstance.loadDataTo(userForm: ContactKeys.firstname) as? String
        mainView.personLastName.text = CacheManager.sharedInstance.loadDataTo(userForm: ContactKeys.lastname) as? String
        mainView.personEmail.text = CacheManager.sharedInstance.loadDataTo(userForm: ContactKeys.email) as? String
        mainView.personPhoneNumber.text = CacheManager.sharedInstance.loadDataTo(userForm: ContactKeys.phone) as? String
        mainView.segmentControlForGenders.selectedSegmentIndex = CacheManager.sharedInstance.loadDataTo(userForm: ContactKeys.segmentIndex) as? Int ?? 0
        mainView.datePickerForBirthDate.date = CacheManager.sharedInstance.loadDataTo(userForm: ContactKeys.birthDate) as? Date ?? .now
    }
    
    //set textfields' data to ls
    private func setDataToLS(_ textField: UITextField) {
        if textField == mainView.personFirstName || textField == mainView.personLastName {
            CacheManager.sharedInstance.setDataFrom(item: mainView.personFirstName.text, userForm: ContactKeys.firstname)
            CacheManager.sharedInstance.setDataFrom(item: mainView.personLastName.text, userForm: ContactKeys.lastname)
        }
        
        if textField == mainView.personEmail {
            CacheManager.sharedInstance.setDataFrom(item: mainView.personEmail.text, userForm: ContactKeys.email)
        }
        
        if textField == mainView.personPhoneNumber {
            CacheManager.sharedInstance.setDataFrom(item: mainView.personPhoneNumber.text, userForm: ContactKeys.phone)
        }
    }
    
    //reset data from ls
    private func resetDataFromLS() {
        CacheManager.sharedInstance.resetDataFrom(UserForm: true)
    }
}

//MARK: - setting active segmentController's index to lc
extension FormViewController {
    private func setSegmentIndexToLS() {
        CacheManager.sharedInstance.setDataFrom(item: mainView.segmentControlForGenders.selectedSegmentIndex, userForm: ContactKeys.segmentIndex)
    }
    
}

//MARK: - setting date data to lc
extension FormViewController {
    private func setDateToLS() {
        CacheManager.sharedInstance.setDataFrom(item: mainView.datePickerForBirthDate.date, userForm: ContactKeys.birthDate)
    }
    
}
