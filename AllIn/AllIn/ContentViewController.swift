//
//  ContentViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/5.
//

import UIKit
import Foundation

protocol ContentViewControllerDelegate {
    func didBackFromContent(_ isChanged: Bool, digestCell: DigestCell)
}

class ContentViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var digestCell: DigestCell?
    var delegate: ContentViewControllerDelegate?
    var isChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let digestCell = digestCell{
                titleLabel.text = digestCell.rssItem._title
        }
        setFavoriteButton(digestCell!.isFavorite)
        
        if let rssLink = digestCell?.rssItem._link {
            print(rssLink)
            var req = URLRequest(urlString: rssLink)!
            req.timeoutInterval = 5
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: req){ (data, response, error) -> Void in
                if error != nil{
                    print(error!.localizedDescription)
                } else{
                    print(String.init(data: data!, encoding: String.Encoding.utf8))
                }
            }
            dataTask.resume()
        } else{
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    @IBAction func favorite(_ sender: UIButton){
        isChanged = !isChanged
        favoriteButton.isSelected = !favoriteButton.isSelected
    }
    
    @IBAction func backUpper(_ sender: UIBarButtonItem){
        if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
            delegate?.didBackFromContent(isChanged, digestCell: digestCell!)
            owningNavigationController.navigationBar.isHidden = false
        }
    }
    
    private func setFavoriteButton(_ favorite: Bool){
        // Set Button
        let bundle = Bundle(for: type(of: self))
        //let isFavorite = UIImage(named: "isFavoriteImage", in: bundle, compatibleWith: self.traitCollection)
        let notFavorite = UIImage(named: "notFavoriteImage", in: bundle, compatibleWith: self.traitCollection)
        
        favoriteButton.setImage(notFavorite, for: .normal)
        favoriteButton.setImage(notFavorite, for: .highlighted)
        favoriteButton.setImage(notFavorite, for: .selected)
        favoriteButton.setImage(notFavorite, for: [.highlighted, .selected])
        
        // Add constraints
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        favoriteButton.isSelected = favorite
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
