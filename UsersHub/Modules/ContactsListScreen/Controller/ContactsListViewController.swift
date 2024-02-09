import Foundation
import UIKit
import RealmSwift

class ContactsListViewController: UIViewController {
    private let mainView = ContactsListView()
    private var contacts: Results<ContactInfo>!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectRow(animated: animated)
    }
    
    private func initViewController() {
        setNavBarStyle()
        initTableView()
        loadDataFromDB()
    }
}

//MARK: - load data from bd
extension ContactsListViewController {
    private func loadDataFromDB() {
        contacts = DBManager.sharedInstance.loadContacts()
    }
}

//MARK: - init items
extension ContactsListViewController {
    private func initTableView() {
        mainView.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
}

//MARK: - tableView
extension ContactsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        let rowData = contacts[indexPath.row]
        cell.handle(with: rowData)
        
        if contacts[indexPath.row].gitHubLogin != "" {
            cell.avatarImage.isHidden = false
            loadUserAvatar(indexPath: indexPath, cell: cell)
        } else {
            cell.avatarImage.isHidden = true
        }
        cell.constraintsUpdate()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editingRows = contacts[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _, _ in
            DBManager.sharedInstance.deleteContact(contact: editingRows)
            tableView.reloadData()
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openContactInfoViewController(for: indexPath)
    }
}

// MARK: - navigation
extension ContactsListViewController {
    private func openContactInfoViewController(for indexPath: IndexPath) {
        let contactInfoViewController = ContactInfoViewContoller()
        contactInfoViewController.personInfo = contacts[indexPath.row]
        navigationController?.pushViewController(contactInfoViewController, animated: true)
    }
    
    private func openFormViewController() {
        let formViewController = FormViewController()
        formViewController.delegate = self
        
        if let sheet = formViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 20
        }
        
        present(formViewController, animated: true)
    }
}

//MARK: - api
extension ContactsListViewController {
    private func loadUserAvatar(indexPath: IndexPath, cell: ContactTableViewCell) {
        
        APIManager.sharedInstance.fetchingUserDetail(userLogin: contacts[indexPath.row].gitHubLogin){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    cell.handleAvatar(with: data)
                    
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
            
        }
    }
    
}

//MARK: - deselecting rows
extension ContactsListViewController {
    private func deselectRow(animated: Bool) {
        if let selectedIndexPath = mainView.tableView.indexPathForSelectedRow {
            mainView.tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
        
        mainView.tableView.reloadData()
    }
}

//MARK: - handlers
extension ContactsListViewController {
    @objc 
    func addContact() {
        openFormViewController()
    }
}

// MARK: - formViewControllerDelegate
extension ContactsListViewController: FormViewControllerDelegate {
    func didContantCreated() {
        let index = IndexPath(row: contacts.count - 1, section: 0)
        mainView.tableView.insertRows(at: [index], with: .left)
    }
}


// MARK: - setting navBar style
extension ContactsListViewController {
    private func setNavBarStyle() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addContact))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: Constants.Colors.forMainElements)
    }
}


