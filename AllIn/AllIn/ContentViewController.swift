//
//  ContentViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/5.
//

import UIKit

class ContentViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    
    var digestCell: DigestCell?
    var delegate: ContentViewControllerDelegate?
    var isChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        if let digestCell = digestCell{
                titleLabel.text = digestCell.title
        }
        
         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    @IBAction func favorite(_ sender: UIButton){
        isChanged = !isChanged
    }
    
    @IBAction func backUpper(_ sender: UIBarButtonItem){
        if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
            delegate?.didBackFromContent(isChanged, digestCell: digestCell!)
            owningNavigationController.navigationBar.isHidden = false
        }
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
