//
//  GuideViewController.swift
//  AllIn
//
//  Created by apple on 2017/12/28.
//

import UIKit

class GuideViewController: UIViewController, UIScrollViewDelegate {

    
    let numOfPages = 2
    
    var btnEnter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = self.view.bounds
        let scrollView = UIScrollView(frame: frame)
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        for i in 0 ..< numOfPages {
            let imgFile = "guide\(Int(i)).png"
            let image = UIImage(named: imgFile)
            let imgView = UIImageView(image: image)
            imgView.frame = CGRect(x:frame.size.width*CGFloat(i), y:CGFloat(0),
                                   width:frame.size.width, height:frame.size.height)
            scrollView.addSubview(imgView)
        }
        scrollView.contentOffset = CGPoint.zero
        
        btnEnter = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        btnEnter.setImage(#imageLiteral(resourceName: "CancelImage"), for: .normal)
        scrollView.addSubview(btnEnter)
        
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //scrollview滚动的时候就会调用
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        let twidth = CGFloat(numOfPages-1) * self.view.bounds.size.width
        //如果在最后一个页面继续滑动的话就会跳转到主页面
        if(scrollView.contentOffset.x > twidth)
        {
            let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let viewController = mainStoryboard.instantiateInitialViewController()
            self.present(viewController!, animated: true, completion:nil)
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
