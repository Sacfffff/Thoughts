//
//  TabBarViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

enum TabBarViewControllers {
    case main
    case profile
    
    var title : String {
        switch self {
        case .main:
           return "Home"
        case .profile:
           return "Profile"
        }
    }
    
    var image : UIImage? {
        switch self {
        case .main:
            return UIImage(systemName: "house")
        case .profile:
            return UIImage(systemName: "person.circle")
        }
    }
    
   static var getAll : [TabBarViewControllers] {
        return [.main, .profile]
    }
}

class TabBarViewController: UITabBarController {
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpControllers()

    }
    


    private func setUpControllers(){
        guard let currentUserEmail = UserDefaults.standard.string(forKey: ConstantKeysUserDefaults.kEmail) else {return}
        let tabControllers = TabBarViewControllers.getAll
        var navigationControllers : [UINavigationController] = []
        let controllers : [UIViewController] = [MainViewController(), ProfileViewController(email: currentUserEmail)]
        
        for (index, controller) in  controllers.enumerated(){
            controller.navigationItem.largeTitleDisplayMode = .always
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.tabBarItem = UITabBarItem(title: tabControllers[index].title, image: tabControllers[index].image, tag: index)
            navigationControllers.append(navigationController)
        }
        
        setViewControllers(navigationControllers, animated: true)
    }

}
