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
        mainNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "digestNavigation") as! UINavigationController
        view.addSubview(mainNavigationController.view)
        
        // Navigation Bar left button item
        mainViewController = mainNavigationController.viewControllers.first as! DigestTableViewController
        mainViewController.navigationItem.leftBarButtonItem?.action = #selector(showMenu as ()->())
        
        // Add Pan Gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(recognizer:)))
        mainNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
        /*
        // Add Tap Gesture to pick up the menu
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePanGesture as () -> ()))
        mainNavigationController.view.addGestureRecognizer(tapGestureRecognizer)
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Properties
    var mainNavigationController: UINavigationController!
    
    var mainViewController: DigestTableViewController!
    
    var menuViewController: MenuViewController?
    
    var currentState = MenuState.Collapsed{
        didSet{
            // show shadow when collapsed
            let shouldShowShadow = currentState != .Collapsed
            showShadowForMainViewController(shouldShowShadow)
        }
    }
    
    let menuViewExpandedOffset: CGFloat = 250
    
    
    //MARK: Actions
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer){
        
        if mainNavigationController.visibleViewController != mainViewController {
            return
        }
        
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
            var positionX = recognizer.view!.frame.origin.x + recognizer.translation(in: view).x
            positionX = positionX < 0 ? 0 : positionX
            
            // Don't move in the left
            recognizer.view!.frame.origin.x = positionX
            recognizer.setTranslation(CGPoint.zero, in: view)
            
        case .ended:
            // Judge whether move halfway
            let hasMovedHalfway = recognizer.view!.center.x > view.bounds.size.width
            animateMainView(shouldExpand: hasMovedHalfway)
        default:
            break
        }
    }
    
    @objc func handlePanGesture() {
        if mainNavigationController.visibleViewController != mainViewController{
            return
        }
        if(currentState != .Expanded){
            return
        }
        
        animateMainView(shouldExpand: false)
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
            animateMainViewXPosition(targetPosition: mainNavigationController.view.frame.width - menuViewExpandedOffset)
        }
        else{
            // To hide
            animateMainViewXPosition(targetPosition: 0, completion: {
                (finished: Bool) -> Void in
                self.currentState = .Collapsed
                self.menuViewController?.view.removeFromSuperview()
                self.menuViewController = nil
            })
        }
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
        }
    }
}

