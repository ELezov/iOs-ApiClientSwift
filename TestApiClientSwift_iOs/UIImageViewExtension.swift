

import Foundation

extension UIImageView
{
    func load(_ string: String){
        self.kf.setImage(with: URL(string: BASE_URL_API+string))
    }
}
