//
//  MenuViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/3.
//

import UIKit

@IBDesignable
class MenuViewController: UIViewController {

    //MARK: Properties
    
    @IBInspectable @IBOutlet weak var menuTableView: UITableView!
    var delegate: MenuViewControllerDelegate?
    var menuCells: [MenuCell]!
    
    enum CellIdentifiers {
            static let menuCell = "MenuTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //menuTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Table View Data Source
extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.menuCell, for: indexPath) as? MenuTableViewCell else {
            fatalError("The dequeued cell is not an instance of MenuTableViewCell")
        }
        cell.configureForMenu(menuCells[indexPath.row])
        return cell
    }
}

//MARK: Table View Delegate
extension MenuViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuCell = menuCells[indexPath.row]
        delegate?.didSelectMenuCell(menuCell)
    }
}
