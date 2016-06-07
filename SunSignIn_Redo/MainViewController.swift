//
//  ViewController.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/12/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    @IBOutlet var gradientView: GradientView!
    
    @IBOutlet var topHeaderView: TopHeaderView!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var mainScrollView: ContentScrollView!
    
    @IBOutlet var sideMenuView: SideMenuView!
    
    @IBOutlet var menuTableView: UITableView!

    @IBOutlet var watermark: UIImageView!
    
    var currentScreen: NavScreen = .Login
    
    
    var controllers = [UIViewController]()
    
    var scrollLayoutCompleted: Bool = false
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.topHeaderView.headerViewDelegate = self
        
        self.gradientView.colors = [ Utils.UIColorFromRGB(Constants.Colors.COLOR_BACKGROUND_GRADIENT_TOP, alpha: 1.0).CGColor, Utils.UIColorFromRGB(Constants.Colors.COLOR_BACKGROUND_GRADIENT_BOTTOM, alpha: 1.0).CGColor ]
        
        self.mainScrollView.contentDelegate = self
        
       // self.loadScroll()
    }
    
    func showScreen(navScreen: NavScreen, size: CGSize, loadData: Bool = false)
    {
       // if navScreen == self.currentScreen
       // {
         //   return
        //}
        
        if navScreen.rawValue > NavScreen.Login.rawValue
        {
            if User.currentUser == nil
            {
                print("NOT LOGGED IN")
                
                return
            }
        }
        
        self.currentScreen = navScreen
        
        self.mainScrollView.scrollEnabled = true
        
        
        let page = navScreen.getScreenPageIndex()
        
        let newX = ((CGFloat(page) * size.width) + (CGFloat(page) * Constants.Layout.CONTAINER_SPACING))
        self.mainScrollView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
        
        self.topHeaderView.setNavItemSelected(navScreen, size: size)
        
        if loadData == true
        {
            let bvc = self.controllers[page] as! BaseViewController
            bvc.loadData()
        }
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        let appScreen = UIScreen.mainScreen().bounds
        
        let scrollWidth = (appScreen.width - (Constants.Layout.SIDE_PADDING * 2) - (Constants.Layout.CONTAINER_SPACING * 2))
        
        if self.mainScrollView.frame.width >= scrollWidth
        {
            if self.scrollLayoutCompleted == false
            {
                self.loadScroll(self.view.size)
            }
        }
        
        print("APP BOUNDS: \(appScreen.size) SCROLL WIDTH: \(self.mainScrollView.bounds), VIEW FRAME: \(self.view.bounds)")
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        self.loadScroll(size)
    }
    
    func loadScroll(size: CGSize)
    {
        for controller in self.controllers
        {
            (controller as! BaseViewController).saveData()
        }
     
        self.mainScrollView.contentView.removeAllSubviewsFromView()
        
        self.controllers.removeAll()
        
        self.scrollLayoutCompleted = true
        
        var nextX = CGFloat(0.0)
        
        let containerWidth = size.width - (Constants.Layout.SIDE_PADDING * 2) - (Constants.Layout.CONTAINER_PADDING)//self.mainScrollView.frame.size.width //appScreen.width - Constants.SIDE_PADDING * 2 - Constants.CONTAINER_PADDING * 2 - nextX
        
        let containerHeight = size.height - (Constants.Layout.TOP_PADDING * 2) - self.topHeaderView.bottom - self.watermark.frame.height
        
        for screen in NavScreen.allValues
        {
            let container = self.getContainerViewForScreen(screen, nextX: nextX, size: CGSize(width: containerWidth, height: containerHeight))
            
            container.delegate = self
            
            if screen.getIdentifier().isEmpty == false
            {
                let newVC = self.storyboard!.instantiateViewControllerWithIdentifier(screen.getIdentifier()) as! BaseViewController
                newVC.view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: containerWidth, height: containerHeight))
                newVC.mainViewController = self
                container.addSubview(newVC.view)
                
                self.controllers.append(newVC)
                
                //container.exclusiveTouch = true
                //newVC.view.centerInSuperview()
            }
            
            self.mainScrollView.contentView.addSubview(container)
            
            print("CONTAINER WIDTH: \(containerWidth) SCROLL WIDTH: \(self.mainScrollView.frame)")
            
            nextX += (containerWidth + Constants.Layout.CONTAINER_SPACING)
        }
        
        nextX -= Constants.Layout.SIDE_PADDING
        
        let contentSize = containerWidth * CGFloat(NavScreen.allValues.count) + (Constants.Layout.CONTAINER_SPACING * (CGFloat(NavScreen.allValues.count) - 1))
        
        self.mainScrollView.contentSize = CGSize(width: contentSize, height: containerHeight)
        
        if User.currentUser != nil && self.currentScreen == .Login
        {
            self.showScreen(NavScreen.Program, size: CGSize(width: containerWidth, height: containerHeight), loadData: true)
        }
        else
        {
            self.showScreen(self.currentScreen, size: CGSize(width: containerWidth, height: containerHeight), loadData: true)
        }
    }
    
    func toggleLeftMenu()
    {
        UIView.animateWithDuration(Constants.ANIMATION_DURATION, animations:
            {
                if self.sideMenuView.frame.origin.x < 0
                {
                    self.sideMenuView.transform = CGAffineTransformTranslate(self.sideMenuView.transform, self.sideMenuView.frame.width, 0)
                    
                    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.screenTapped(_:)))
                    self.mainView.addGestureRecognizer(tapRecognizer)
                }
                else
                {
                    self.sideMenuView.transform = CGAffineTransformTranslate(self.sideMenuView.transform, -self.sideMenuView.frame.width, 0)
                    
                    self.mainView.gestureRecognizers = nil
                }
        })
    }

    func screenTapped(gesture: UITapGestureRecognizer)
    {
        self.toggleLeftMenu()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getContainerViewForScreen(screen: NavScreen, nextX: CGFloat, size: CGSize) -> ContainerView
    {
       // if screen == .Login
        //{
          //  return LoginInputView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.mainScrollView.width, height: self.mainScrollView.height)))
        //}
        
        return ContainerView(frame: CGRect(origin: CGPoint(x: nextX, y: 0), size: size))
    }
    
    func logout()
    {
        User.currentUser = User()
        self.showScreen(.Login, size: self.mainScrollView.size)
    }
    
    

}

extension MainViewController: TopHeaderViewDelegate
{
    func topHeaderViewDidRequestScreen(navScreen: NavScreen)
    {
        switch navScreen
        {
            case .Settings:
                self.toggleLeftMenu()
                break
            
            default:
                self.showScreen(navScreen, size: self.mainScrollView.size, loadData: true)
                //let newX = ((CGFloat(page) * self.mainScrollView.frame.width) + (CGFloat(page) * Constants.Layout.CONTAINER_SPACING))
                //self.mainScrollView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
                break
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MenuScreen.allScreens.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifiers.MENU_CELL_IDENTIFIER) as! MenuCell
        
        let screen = MenuScreen(rawValue: indexPath.row)
        cell.menuTitle.text = screen?.getTitle()
        cell.menuImage.image = screen?.getImage()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let screen = MenuScreen(rawValue: indexPath.row)
        
        self.toggleLeftMenu()
        
        if screen == .EventsList
        {
            let newVC = self.storyboard!.instantiateViewControllerWithIdentifier(Constants.EVENT_LIST_VIEW_CONTROLLER) as! EventListViewController
            self.navigationController?.pushViewController(newVC, animated: true)
        }
        else if screen == .LogOut
        {
            self.logout()
        }
    }
    
}

extension MainViewController: ContainerViewDelegate
{
    func containerViewDidRequestLogin(user: String, pass: String)
    {
        APIManager.sharedManager.getAPIRequest(Constants.APIEndpoints.API_ENDPOINT_LOGIN, method: Constants.HTTPRequestMethods.HTTP_GET, parameters: [ user, pass ])
        { (data, error) in
            let user = User(json: data as! NSDictionary)
            User.currentUser = user
        }
    }
    
    func containerViewDidRequestForgotPassword(user: String)
    {
        APIManager.sharedManager.getAPIRequest(Constants.APIEndpoints.API_ENDPOINT_FORGOT_PASSWORD, method: Constants.HTTPRequestMethods.HTTP_GET, parameters: [ user ])
        { (data, error) in
            
        }
    }
}

extension MainViewController: ContentScrollViewDelegate
{
    func contentDidScrollToPage(page: Int)
    {
        let navScreen = NavScreen.allValues[page]
        
        self.showScreen(navScreen, size: self.mainScrollView.size, loadData: (self.currentScreen != navScreen))
    }
}