//
//  ContentViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/5.
//

import UIKit
import Foundation
import Fuzi

protocol ContentViewControllerDelegate {
    func didBackFromContent(_ isChanged: Bool, digestCell: DigestCell)
}

class ContentViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var contentText: UITextView!
    
    var digestCell: DigestCell?
    var delegate: ContentViewControllerDelegate?
    var isChanged = false
    var _webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "ReturnImage")

        /*
        fontSizeButton.setImage(#imageLiteral(resourceName: "FontSizeImage"), for: .normal)
        fontSizeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        fontSizeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
         */
        
        contentText.isEditable = false
        
        if let digestCell = digestCell{
            titleLabel.text = digestCell.rssItem._title
        }
        setFavoriteButton(digestCell!.isFavorite)
        
        parserLink()
        titleLabel.adjustsFontSizeToFitWidth = true
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
            owningNavigationController.navigationBar.isHidden = true
        }
    }
    
    private func setFavoriteButton(_ favorite: Bool){
        // Set Button
        let bundle = Bundle(for: type(of: self))
        
        //let isFavorite = UIImage(named: "isFavoriteImage", in: bundle, compatibleWith: self.traitCollection)
        let notFavorite = UIImage(named: "isFavoriteImage", in: bundle, compatibleWith: self.traitCollection)
        
        favoriteButton.setImage(notFavorite, for: .normal)
        favoriteButton.setImage(notFavorite, for: .highlighted)
        favoriteButton.setImage(notFavorite, for: .selected)
        favoriteButton.setImage(notFavorite, for: [.highlighted, .selected])
        
        // Add constraints
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        favoriteButton.isSelected = favorite
    }
    
    private func setReaded(){
        self.digestCell?.isReaded = true
    }
    
    private func parserLink() {
        if let rssLink = digestCell?.rssItem._link {
            if digestCell?.rssItem._source != "ZhihuDaily" {
                _webView = UIWebView(frame: CGRect.init(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y + (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.height)!))
                _webView?.scalesPageToFit = true
                _webView?.scrollView.bounces = false
                self.view.addSubview(_webView!)
                let url = URL(string: rssLink)!
                let req = URLRequest(url: url)
                _webView?.loadRequest(req)
                //_webView?.string
                
            } else {
                let url = URL(string: rssLink)!
                var req = URLRequest(url: url)
                req.timeoutInterval = 5
                let session = URLSession.shared
                
                let dataTask = session.dataTask(with: req){ (data, response, error) -> Void in
                    if error != nil{
                        print(error!.localizedDescription)
                    } else{
                        // 将data转为attributedString，图片无法自适应且无法定制属性
                        /*
                         let attributedString = try? NSAttributedString.init(data: data!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                         DispatchQueue.main.async {
                         self.contentText.insertString(attributedString)
                         }
                         */
                        if self.digestCell?.rssItem._source == "ZhihuDaily"{
                            let zhihuDailiyHTMLParser = ZhihuDailyHTMLParser()
                            zhihuDailiyHTMLParser.parser(data: data){
                                (content, img) -> Void in
                                if let str = content {
                                    DispatchQueue.main.async {
                                        self.contentText.insertString(str)
                                    }
                                }
                                if let srcImage = img {
                                    DispatchQueue.main.async {
                                        self.contentText.insertPicture(srcImage, mode: .fitTextView)
                                    }
                                }
                            }
                        }
                    }
                }
                dataTask.resume()
            }
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
