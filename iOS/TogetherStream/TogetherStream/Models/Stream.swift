//
//  © Copyright IBM Corporation 2017
//  LICENSE: MIT http://ibm.biz/license-ios
//

import CSyncSDK

struct Stream {
    let name: String
    let csyncPath: String
    let description: String
    let hostFacebookID: String
    
    private var currentVideoKey: Key
    
    init?(jsonDictionary: [String: Any]) {
        guard let csyncPath = jsonDictionary["csync_path"] as? String,
            let name = jsonDictionary["stream_name"] as? String,
            let description = jsonDictionary["description"] as? String,
            let externalAccounts = jsonDictionary["external_accounts"] as? [String: String],
            let hostFacebookID = externalAccounts["facebook-token"] else {
            return nil
        }
        self.name = name
        self.csyncPath = csyncPath
        self.description = description
        self.hostFacebookID = hostFacebookID
        
        currentVideoKey = CSyncDataManager.sharedInstance.createKey(atPath: csyncPath + ".currentVideoID")
    }
    
    init(name: String, csyncPath: String, description: String, hostFacebookID: String) {
        self.name = name
        self.csyncPath = csyncPath
        self.description = description
        self.hostFacebookID = hostFacebookID
        
        currentVideoKey = CSyncDataManager.sharedInstance.createKey(atPath: csyncPath + ".currentVideoID")
    }
    
    func listenForCurrentVideo(callback: @escaping (Error?, String?) -> Void) {
        currentVideoKey.listen {value, error in
            if let value = value?.data {
                callback(nil, value)
            }
            else {
                callback(error, nil)
            }
        }
    }
    
    func stopListeningForCurrentVideo() {
        currentVideoKey.unlisten()
    }
    
    
}
