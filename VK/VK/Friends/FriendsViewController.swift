//
//  FriendsViewController.swift
//  VK
//
//  Created by пользовтель on 02.03.2021.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let VKServ = VKService()
    
    var keys: [String] = []
    var friendSorted: [String:[Friend]] = [:]
    var friendsFiltered: [Friend] = []
    
    let searchController = UISearchController (searchResultsController: nil)
    var arrayOfUsers: [Friend] = []
    var isSearchBarEmpty: Bool {return searchController.searchBar.text?.isEmpty ?? true}
    var isFilltering: Bool { return searchController.isActive && !isSearchBarEmpty}
    
    var friendGet: [Friend] = []
    
    func checkSearchFilter() {
        keys = []
        arrayOfUsers = []
        friendSorted = [:]
        if isFilltering {
            arrayOfUsers = friendsFiltered
        } else {
            arrayOfUsers = friendGet
        //    print (arrayOfUsers.map { $0.firstName + " " + $0.lastName})
        }
        for user in arrayOfUsers {
            let firstLetter = String(user.firstName.first!)
            if friendSorted[firstLetter] != nil {
                friendSorted[firstLetter]?.append(user)
            } else {
                friendSorted[firstLetter] = [user]
            }
        }
        keys = Array (friendSorted.keys).sorted(by: <)
    }
    
    //MARK - : Массив друзей, которые пытаемся получить от сервера
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //пытаюсь получить ответ от сервера ВК со данными друга
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.VKServ.loadFriendData(extraPath: "friends.get") { [weak self] ArrayOffriends in
                self?.friendGet = ArrayOffriends
                self?.checkSearchFilter()
            }
        }
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        checkSearchFilter()
        return friendSorted.count
    }
    @IBOutlet weak var friendsTableView: UITableView! {
        didSet {
            friendsTableView.delegate = self
            friendsTableView.dataSource = self
        }
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        checkSearchFilter()
        return keys
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        checkSearchFilter()
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in self?.checkSearchFilter()
        }
        view.tintColor = UIColor.gray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.text = keys[section]
        header.alpha = 0.5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkSearchFilter()
        let key = keys[section]
        return friendSorted[key]!.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkSearchFilter()
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell") as! UserTableViewCell
        cell.backgroundColor = UIColor.clear
    
        let key = keys[indexPath.section]
        let user = friendSorted[key]![indexPath.row]
        let fio = user.firstName + " " + user.lastName
        let avatar = user.avatar
        cell.nameLabl.text = fio
        cell.avatarImage.image = UIImage (named: avatar)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkSearchFilter()
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(identifier: "PhotoVC") as! PhotoViewController
        let key = keys[indexPath.section]
        let user = friendSorted[key]![indexPath.row]
        
 //       VC.photoArray = user
        show(VC, sender: nil)
    }
    func filteredContentForSearchText (_ searchText: String) {
        friendsFiltered = friendGet.filter { (friend: Friend) -> Bool in
            return friend.lastName.lowercased().contains(searchText.lowercased())
        }
       
        friendsTableView.reloadData()
    }
}
extension UITableView {
    @IBInspectable var backgroundImage: UIImage? {
        get {
            return nil
        }
        set {
            backgroundView = UIImageView(image: newValue)
        }
    }
}
extension FriendsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filteredContentForSearchText(searchBar.text!)
    }
}
