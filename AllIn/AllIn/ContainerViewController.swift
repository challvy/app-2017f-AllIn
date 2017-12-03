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
        
        // Add main view
        mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainView") as! MainViewController
        view.addSubview(mainViewController.view)
        
        // Establish father-child relationship
        addChildViewController(mainViewController)
        mainViewController.didMove(toParentViewController: self)
        
        // Add Pan Gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(recognizer:)))
        mainViewController.view.addGestureRecognizer(panGestureRecognizer)
        
        // Add Tap Gesture to pick up the menu
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePanGesture as () -> ()))
        mainViewController.view.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Properties
    var mainViewController:MainViewController!
    var menuViewController:MenuViewController?
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
            let positionX = recognizer.view!.frame.origin.x + recognizer.translation(in: view).x
            recognizer.view!.frame.origin.x = positionX < 0 ? 0 : positionX
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
        if currentState == .Expanded{
            animateMainView(shouldExpand: false)
        }
    }
    
    func addMenuViewController(){
        if(menuViewController==nil){
            menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menuView") as? MenuViewController
            view.insertSubview(self.menuViewController!.view, at: 0)
            
            addChildViewController(menuViewController!)
            menuViewController!.didMove(toParentViewController: self)
        }
    }
    
    func animateMainView(shouldExpand: Bool) {
        if(shouldExpand){
            // To expand
            currentState = .Expanded
            // Movie
            animateMainViewXPosition(targetPosition: mainViewController.view.frame.width - menuViewExpandedOffset)
        }
        else{
            // To hide
            animateMainViewXPosition(targetPosition: 0, completion: { (finished: Bool) -> Void in
                // Update state
                self.currentState = .Collapsed
                // Movie
                self.menuViewController?.view.removeFromSuperview()
                self.menuViewController = nil
            })
        }
    }
    
    func animateMainViewXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { self.mainViewController.view.frame.origin.x = targetPosition }, completion: completion)
    }
    
    func showShadowForMainViewController(_ shouldShowShadow: Bool) {
        // set/cancel shadow for MainView
        if(shouldShowShadow){
            mainViewController.view.layer.shadowOpacity = 0.8
        }
        else{
            mainViewController.view.layer.shadowOpacity = 0
        }
    }
}

