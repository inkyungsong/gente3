//
//  FlowViewController.swift
//  Gente3
//
//  Created by KS23225 on 11/22/17.
//  Copyright © 2017 IKSong. All rights reserved.
//

import UIKit

class FlowViewController: UIViewController {

    init() { super.init(nibName: nil, bundle: nil) }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userVC = UsersTableViewController(items: [], resource: User.resourceForAllUsers(), cellDescriptor: CellDescriptor(configure: {$1.configure($0)}))
        userVC.delegate = self
        
        transition(to: userVC)
    }

    func loadResource<T: Codable>(_ resource: Resource<[T]>) where T: CellConfigurable {
        let postVC = ItemsTableViewController<T>(items: [], resource: resource, cellDescriptor: CellDescriptor(configure: {$1.configure($0)}))
        navigationController?.pushViewController(postVC, animated: true)
    }
}

extension FlowViewController: UsersTableViewControllerDelegate {
    func userTableViewControllerDidSelectUser(_ user: User) {
        guard let resource = Post.postResourceForUserID(id: String(user.id)) else { return }
        loadResource(resource)
    }
}
