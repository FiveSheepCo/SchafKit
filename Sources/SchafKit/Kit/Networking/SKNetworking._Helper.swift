import Foundation

private let standardError = NSError(domain: "Invalid URL", code: SchafKitErrorCode, userInfo: nil)

extension SKNetworking {
    internal class _Helper : NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDownloadDelegate {
        static let shared: _Helper = _Helper()
        private var urlSession : URLSession!
        private var optionsPerTask: [URLSessionTask : SKOptionSet<SKNetworking.Request.Options>] = [:]
        private var updateHandlerPerTask: [URLSessionDownloadTask : (update : DownloadRequestUpdateBlock, completion : DownloadRequestCompletionBlock)] = [:]
        
        private struct Default {
            static let timeoutInterval : TimeInterval = 60
            static let cachePolicy : URLRequest.CachePolicy = .useProtocolCachePolicy
        }
        
        override private init() {
            super.init()
            
            urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        }
        
        // MARK: - Requests
        // MARK: Standard Request
        
        func request(url urlString : String,
                      options : SKOptionSet<SKNetworking.Request.Options>,
                      completion: @escaping RequestCompletionBlock) {
            let request : URLRequest
            do {
                request = try buildRequest(with: urlString, options: options)
            } catch let error as NSError {
                completion(.failure(error))
                return
            }
            
            var task: URLSessionDataTask!
            task = urlSession.dataTask(with: request) { (data, response, error) in
                if let result = SKNetworking.RequestResult(data: data, originalRequest: task.originalRequest ?? request, response: response) {
                    completion(.success(result))
                } else {
                    completion(.failure(error ?? standardError))
                }
                
                self.clearTasks()
            }
            
            urlSession.delegateQueue.addOperation { [self] in
                optionsPerTask[task] = options
                task.resume()
            }
            
        }
        
        // MARK: Download Request
        
        func requestDownload(url urlString : String,
                              options : SKOptionSet<SKNetworking.Request.Options>,
                              update: @escaping DownloadRequestUpdateBlock,
                              completion: @escaping DownloadRequestCompletionBlock) {
            let request : URLRequest
            do {
                request = try buildRequest(with: urlString, options: options)
            } catch let error as NSError {
                completion(.failure(error))
                return
            }
            
            let task = urlSession.downloadTask(with: request)
            
            urlSession.delegateQueue.addOperation { [self] in
                optionsPerTask[task] = options
                updateHandlerPerTask[task] = (update, completion)
                
                task.resume()
            }
        }
        
        // MARK: - Build Request
        
        private func buildRequest(with urlString : String, options : SKOptionSet<SKNetworking.Request.Options>) throws -> URLRequest {
            guard let url = URL(string: urlString) else {
                throw standardError
            }
            
            var cachePolicy : URLRequest.CachePolicy = Default.cachePolicy
            for case .cachePolicy(let value) in options { cachePolicy = value }
            
            var timeoutInterval : TimeInterval = Default.timeoutInterval
            for case .timeoutInterval(let value) in options { timeoutInterval = value }
            
            var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
            
            for case .requestMethod (let method) in options { request.httpMethod = method.rawValue }
            for case .body(let value) in options {
                request.httpBody = value.body
                
                guard let type = value.type else {
                    break
                }
                
                request.addValue(type, forHTTPHeaderField: "Content-Type")
            }
            
            for case .headerFields (let value) in options {
                for keyValuePair in value {
                    request.addValue(keyValuePair.value, forHTTPHeaderField: keyValuePair.key.name)
                }
            }
            
            return request
        }
        
        // MARK: - URLSessionDelegate
        
        func urlSession(_ session : URLSession, task : URLSessionTask, didReceive challenge : URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            // TODO: Handle only non HTTPS, etc?
            
            for case .authChallengeHandler(let value) in (optionsPerTask[task] ?? []) {
                value(challenge, completionHandler)
                return
            }
            
            completionHandler(.performDefaultHandling, nil)
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
            updateHandlerPerTask[downloadTask]?.update(totalBytesWritten, totalBytesExpectedToWrite)
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            if let completion = updateHandlerPerTask[downloadTask]?.completion {
                if let result = SKNetworking.DownloadResult(url: location, response: downloadTask.response) {
                    completion(.success(result))
                } else {
                    completion(.failure(standardError))
                }
            }
            
            self.clearTasks()
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            if let task = task as? URLSessionDownloadTask, let completion = updateHandlerPerTask[task]?.completion {
                completion(.failure(error ?? standardError))
            }
            
            
            self.clearTasks()
        }
        
        private func clearTasks() {
            for task in optionsPerTask.keys {
                if [URLSessionTask.State.completed, URLSessionTask.State.canceling].contains(task.state) {
                    optionsPerTask[task] = nil
                }
            }
        }
    }
}
