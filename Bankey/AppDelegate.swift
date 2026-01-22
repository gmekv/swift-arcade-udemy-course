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
    let   onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewControoler = DummyViewController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        dummyViewControoler.logoutDelegate = self
        
        window?.rootViewController = loginViewController
        
        
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
    
    func didFinish() {
        print("Finished")
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewControoler)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
    
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewControoler)
            return
        }
        setRootViewController(onboardingContainerViewController)
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


