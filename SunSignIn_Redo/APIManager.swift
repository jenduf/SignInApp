//
//  APIManager.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/28/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

class APIManager: NSObject, NSURLSessionDelegate, NSURLSessionDataDelegate
{
    static let sharedManager = APIManager()
    
    override private init()
    {
        
    }
    
    private var currentTask: NSURLSessionTask!
    lazy var session: NSURLSession =
        {
            let queue = NSOperationQueue.mainQueue()
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            return NSURLSession(configuration: config, delegate: self, delegateQueue: queue)
    }()
    
    // MARK: Parse Helpers
    func parseJSONResponse(json: NSData?) -> AnyObject?
    {
        do
        {
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(json!, options: .AllowFragments)
            print("JSON Data: \(jsonObject)")
            return jsonObject
        }
        catch
        {
            let nsError = error as NSError
            print("JSON Error: \(nsError), DATA: \(json)")
        }
        
        return nil
    }
    
    func dictionaryToJSON(dictionary: AnyObject) -> NSData?
    {
        do
        {
            let data = try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
            print(NSString(data: data, encoding: NSUTF8StringEncoding))
            return data
        }
        catch
        {
            let nsError = error as NSError
            print("Convert error: \(nsError)")
        }
        
        return nil
    }
    
    func dictionaryToQueryString(dictionary: [String : String]) -> String
    {
        let pairString: NSMutableString = NSMutableString(string: "")
        
        for key in dictionary.keys
        {
            let firstKey = dictionary.keys.first
            if !(key == firstKey)
            {
                pairString.appendString("&")
            }
            
            let value = dictionary[key]?.stringByReplacingOccurrencesOfString(" ", withString: "+")
            pairString.appendString("\(key)=\(value!)")
        }
        
        let convertedString = NSString(string: pairString)
        print(convertedString)
        
        return "\(pairString)"
       // let queryData = convertedString.dataUsingEncoding(NSUTF8StringEncoding)
       /// return queryData!
    }
    
    func getAPIRequestNamed(apiRequest: APIRequest, completion: (data: AnyObject?, error: NSError?) -> Void)
    {
        var parameterString = ""
        
        if apiRequest.parameters?.isEmpty == false
        {
             parameterString = self.dictionaryToQueryString(apiRequest.parameters!)
        }
        
        let urlString = "\(apiRequest.url)\(apiRequest.endPoint!)\(parameterString)"
        
        print("ENDPOINT w/ PARAMETERS: \(urlString)")
        
        
        let url = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = apiRequest.requestType!
       // request.HTTPBody = self.dictionaryToJSON(apiRequest.parameters!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        self.currentTask = self.session.dataTaskWithRequest(request, completionHandler:
            { (data, response, error) -> Void in
                
                if let jsonDict = self.parseJSONResponse(data) as? NSDictionary
                {
                    completion(data: jsonDict, error: error)
                }
        })
        
        self.currentTask.resume()
    }
    
    // MARK: API Request Builder
    func getAPIRequest(requestName: String = "", method: String = Constants.HTTPRequestMethods.HTTP_GET, parameters: [String] = [String](), completion: (data: AnyObject?, error: NSError?) -> Void)
    {
        var parameterString = ""
        
        for parameter in parameters
        {
            parameterString.appendContentsOf("/\(parameter)")
        }
        
        let urlString = "\(Constants.API_URL)\(requestName)\(parameterString)"
        
        print("ENDPOINT w/ PARAMETERS: \(urlString)")
        
        
        let url = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    
        self.currentTask = self.session.dataTaskWithRequest(request, completionHandler:
        { (data, response, error) -> Void in
            
            if let jsonDict = self.parseJSONResponse(data) as? NSDictionary
            {
                completion(data: jsonDict, error: error)
            }
        })
        
        self.currentTask.resume()
    }
}