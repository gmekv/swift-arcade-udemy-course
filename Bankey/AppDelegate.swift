//
//  AppDelegate.swift
//  Bankey
//
//  Created by Giorgi Mekvabishvili on 13.01.26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewControoler = DummyViewController()
    let mainViewController = MainViewController()
    let accountSummaryViewController = AccountSummaryViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        // Configure navigation bar appearance globally
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = appColor
        appearance.shadowColor = .clear  // Removes the bottom line
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
        
        displayLogin()
        return true
    }
    
    
    private func displayLogin() {
    setRootViewController(loginViewController)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
    
    
    private func prepMainView() {
        // Navigation bar is already configured globally in didFinishLaunchingWithOptions
    }
    
    
}

extension AppDelegate: LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
    
    func didFinish() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
    
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}


extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}


