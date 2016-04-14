//
//  AppDelegate.swift
//  Cumulus
//
//  Created by Michiel De Mey on 07/03/16.
//  Copyright © 2016 Michiel De Mey. All rights reserved.
//

import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder,
    UIApplicationDelegate,
    TVApplicationControllerDelegate {

    var window: UIWindow?
    var appController: TVApplicationController?
    
    static let TVBaseURL = "http://michieldemey.local:8000"
    // static let TVAuthUrl = "https://cumulus-auth.herokuapp.com"
    static let TVAuthUrl = "https://cumulus.astromo.io"
    //static let TVAuthUrl = "http://michieldemey.local:3000"
    static let TVBootURL = "\(AppDelegate.TVBaseURL)/dist/app.js"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        /*
        Create the TVApplicationControllerContext for this application
        */
        let appControllerContext = TVApplicationControllerContext()
        
        /*
        The JavaScript URL is used to create the JavaScript context for your
        TVMLKit application. Although it is possible to separate your JavaScript
        into separate files, to help reduce the launch time of your application
        we recommend creating minified and compressed version of this resource.
        This will allow for the resource to be retrieved and UI presented to
        the user quickly.
        */
        if let javaScriptURL = NSURL(string: AppDelegate.TVBootURL) {
            appControllerContext.javaScriptApplicationURL = javaScriptURL
        }
        
        /*
        Set the properties that will be passed to the `App.onLaunch` function
        in JavaScript.
        */
        appControllerContext.launchOptions["BASEURL"] = AppDelegate.TVBaseURL
        appControllerContext.launchOptions["AUTHURL"] = AppDelegate.TVAuthUrl
        if let launchOptions = launchOptions as? [String: AnyObject] {
            for (kind, value) in launchOptions {
                appControllerContext.launchOptions[kind] = value
            }
        }
        
        appController = TVApplicationController(context: appControllerContext, window: window, delegate: self)
        
        return true
    }
}

