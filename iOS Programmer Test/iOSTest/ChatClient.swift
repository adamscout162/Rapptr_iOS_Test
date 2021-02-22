//
//  ChatClient.swift
//  iOSTest
//
//  Created by Adam Israfil on 2/21/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import Foundation

class ChatClient {
    
    func getChatMessages(completion: @escaping (_ messages: [Message]?) -> ()) {
        
        guard let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php") else { return }
        let chatRequest = URLRequest(url: url)
        
        let chatRequestSession = URLSession.shared.dataTask(with: chatRequest) { (data, responseInformation, error) in
            guard let data = data, error == nil else {
                return
            }
            
            guard let responseInformation = responseInformation as? HTTPURLResponse, (200...299).contains(responseInformation.statusCode) else {
                return
            }
            
            do {
                guard let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[Any]],
                      let messagesData = responseDict["data"] else {
                    completion(nil)
                    return
                }
                
                let messages = messagesData.compactMap { (item) -> Message? in
                    guard let messageData = item as? [AnyHashable : Any] else { return nil }
                    print(messageData)
                    return Message(dictionary: messageData)
                }
                
                completion(messages)
                return
            } catch {
                completion(nil)
                return
            }
        }
        chatRequestSession.resume()
    }
}
