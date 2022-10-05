#if canImport(UIKit)
import UIKit

extension UIApplication {
    
    func open(url: String) {
        guard let url = URL(string: url) else {
            print("`UIApplication.open(url: String)` received a string that does not produce a valid URL:", url)
            return
        }
        
        open(url, options: [:], completionHandler: nil)
    }
    
    func openSettings() {
        open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}
#endif
