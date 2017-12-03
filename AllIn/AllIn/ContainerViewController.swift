//
//  ViewController.swift
//  AllIn
//
//  Created by Apple on 2017/11/27.
//

import UIKit

// Men State
enum MenuState{
    case Collapsed
    case Expanding
    case Expanded
}

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set StatusBar Content Light Color
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Add background for root container
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = UIScreen.main.bounds
        self.view.addSubview(imageView)
        
        // Initialize Main View
        mainNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainNavigation") as! UINavigationController
        view.addSubview(mainNavigationController.view)
        
        // Navigation Bar left button item
        mainViewController = mainNavigationController.viewControllers.first as! MainViewController
        mainViewController.navigationItem.leftBarButtonItem?.action = #selector(showMenu as ()->())
        
        // Add Pan Gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(recognizer:)))
        mainNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
        // Add Tap Gesture to pick up the menu
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePanGesture as () -> ()))
        mainNavigationController.view.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Properties
    var mainNavigationController: UINavigationController!
    
    var mainViewController: MainViewController!
    
    var menuViewController: MenuViewController?
    
    var blackCover: UIView?
    
    var currentState = MenuState.Collapsed{
        didSet{
            // show shadow when collapsed
            let shouldShowShadow = currentState != .Collapsed
            showShadowForMainViewController(shouldShowShadow)
        }
    }
    
    let menuViewExpandedOffset: CGFloat = 250
    
    let minProportion: CGFloat = 0.88
    
    
    //MARK: Actions
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            // Judge direction
            let dragFromLeftToRight = (recognizer.velocity(in: view).x > 0)
            if (currentState == .Collapsed && dragFromLeftToRight){
                currentState = .Expanding
                addMenuViewController()
            }
            
        case .changed:
            // Move mainview with gesture
            let screenWidth = view.bounds.size.width
            var centerX = recognizer.view!.center.x + recognizer.translation(in: view).x
            // Don't move if view has moved to left
            centerX = ( centerX < screenWidth/2 ) ? screenWidth : centerX
            
            // Calculate proportion
            var proportion: CGFloat = (centerX - screenWidth/2)/(view.bounds.size.width - menuViewExpandedOffset)
            proportion = 1 - proportion * (1 - minProportion)
            
            blackCover?.alpha = (proportion - minProportion) / (1 - minProportion)
            
            recognizer.view!.center.x = centerX
            recognizer.setTranslation(CGPoint.zero, in: view)
            
            // scale main view
            recognizer.view!.transform = CGAffineTransform.identity.scaledBy(x: proportion, y: proportion)
            
        case .ended:
            // Judge whether move halfway
            let hasMovedHalfway = recognizer.view!.center.x > view.bounds.size.width
            animateMainView(shouldExpand: hasMovedHalfway)
        default:
            break
        }
    }
    
    @objc func handlePanGesture() {
        if currentState == .Expanded{
            animateMainView(shouldExpand: false)
        }
    }
    
    @objc func showMenu() {
        if currentState == .Expanded{
            animateMainView(shouldExpand: false)
        }
        else{
            addMenuViewController()
            animateMainView(shouldExpand: true)
        }
    }
    
    //MARK: Animmation
    func animateMainView(shouldExpand: Bool) {
        if(shouldExpand){
            // To expand
            currentState = .Expanded
            // Movie
            let mainPosition = view.bounds.size.width * (1 + minProportion/2) - menuViewExpandedOffset
            doTheAniminate(mainPosition: mainPosition, mainProportion: minProportion, blackCoverAlpha: 0)
        }
        else{
            // To hide
            doTheAniminate(mainPosition: view.bounds.size.width/2, mainProportion: 1, blackCoverAlpha: 1, completion: { (finish: Bool)-> Void in
                self.currentState = .Collapsed
                self.menuViewController?.view.removeFromSuperview()
                self.menuViewController = nil
                self.blackCover?.removeFromSuperview()
                self.blackCover = nil
            })
        }
    }
    
    func doTheAniminate(mainPosition: CGFloat, mainProportion: CGFloat, blackCoverAlpha: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.mainNavigationController.view.center.x = mainPosition
            self.blackCover?.alpha = blackCoverAlpha
            // Scale main view
            self.mainNavigationController.view.transform = CGAffineTransform.identity.scaledBy(x: mainProportion, y: mainProportion)
        }, completion: completion)
        
    }
    func animateMainViewXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { self.mainNavigationController.view.frame.origin.x = targetPosition }, completion: completion)
    }
    
    func showShadowForMainViewController(_ shouldShowShadow: Bool) {
        // set/cancel shadow for MainView
        if(shouldShowShadow){
            mainNavigationController.view.layer.shadowOpacity = 0.8
        }
        else{
            mainNavigationController.view.layer.shadowOpacity = 0
        }
    }
    
    //MARK: Menu view controller
    func addMenuViewController(){
        if(menuViewController==nil){
            menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menuView") as? MenuViewController
            view.insertSubview(menuViewController!.view, belowSubview: mainNavigationController.view)
            
            addChildViewController(menuViewController!)
            menuViewController!.didMove(toParentViewController: self)
            
            // Add black cover
            blackCover = UIView(frame: self.view.frame.offsetBy(dx: 0, dy: 0))
            blackCover!.backgroundColor = UIColor.black
            self.view.insertSubview(blackCover!, belowSubview: mainNavigationController.view)
        }
    }
}

