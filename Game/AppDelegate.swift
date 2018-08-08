import UIKit
import Magic
import SwiftKeychainWrapper
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var currentCharacterId: Int?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Очищение базы
    // autoclearRealmDatabase()
    
    openRealm()
    
    // Генерируем пользователю уникальный id если оного ещё нет.
    // В дальнейшем по этому к этому id будут привязываться пресонажи героя и вещи на аукционе.
    if KeychainWrapper.standard.string(forKey: "userId") == nil {
      KeychainWrapper.standard.set(UUID().uuidString, forKey: "userId")
    }
    
    return true
  }
  
  func openRealm() {
    
    let defaultPath = Realm.Configuration.defaultConfiguration.fileURL!
    let path = Bundle.main.url(forResource: "default", withExtension: "realm")
    
    if let bundledPath = path {
      
      magic("use pre-populated database")
      do {
        try FileManager.default.removeItem(at: defaultPath)
        try FileManager.default.copyItem(at: bundledPath, to: defaultPath)
        
      } catch {
        magic("remove")
        magic(error)
      }
    }
    
    
    
    //    let defaultRealmPath  = Realm.Configuration.defaultConfiguration.fileURL!
    //    let bundleRealmPath   = Bundle.main.url(forResource: "default", withExtension: "realm")
    //    
    //    if !FileManager.default.fileExists(atPath: defaultRealmPath.absoluteString) {
    //      do {
    //        try FileManager.default.copyItem(at: bundleRealmPath!, to: defaultRealmPath)
    //      } catch let error {
    //        magic("error copying seeds: \(error)")
    //      }
    //    }
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  /// Отчищение базы. Используется в development-режиме
  func autoclearRealmDatabase() {
    let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
    
    let realmURLs = [
      realmURL,
      realmURL.appendingPathExtension("lock"),
      realmURL.appendingPathExtension("note"),
      realmURL.appendingPathExtension("management")
    ]
    for URL in realmURLs {
      do {
        try FileManager.default.removeItem(at: URL)
      } catch {
        // handle error
      }
    }
  }
}

