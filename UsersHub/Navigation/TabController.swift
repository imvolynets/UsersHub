import Foundation
import UIKit

class TabController:  UITabBarController  {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewController()
    }
    
    private func initViewController() {
        setupTabs()
        setupTabBar()
    }
}

// MARK: - helpers
extension TabController {
    private func setupTabs() {
        let users = self.createNav(with: "git_users_title".localized, and: UIImage(systemName: "person"), for: UsersListViewController())
        let home = self.createNav(with: "Contacts", and: UIImage(systemName: "person.badge.plus"), for: ContactsListViewController ())

        self.setViewControllers([users, home], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, for vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont(name: Constants.Fonts.mainFont, size: 16) ?? .systemFont(ofSize: 16), .foregroundColor: UIColor(named: Constants.Colors.forMainElements) ?? .systemGray]
        nav.viewControllers.first?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        nav.viewControllers.first?.navigationItem.backBarButtonItem?.tintColor = UIColor(red: 0.83, green: 0.86, blue: 0.89, alpha: 1.00)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        
        return nav
    }
}

//MARK: - setting tabBar
extension TabController {
    private func setupTabBar() {
        UITabBar.appearance().barTintColor = UIColor(red: 0.22, green: 0.20, blue: 0.21, alpha: 1.00)
        UITabBar.appearance().tintColor = UIColor(red: 0.83, green: 0.86, blue: 0.89, alpha: 1.00)
        UITabBar.appearance().isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            appearance.backgroundColor = UIColor(red: 0.22, green: 0.20, blue: 0.21, alpha: 1.00)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }
}
